#!/usr/bin/env bash
# Builds the asm 9.9 OSGi bundles that jdtls needs before java-test will load.
#
# Why this exists:
#   Mason's java-test 0.43 requires asm [9.9,9.10) but Mason's jdtls 1.60 ships
#   asm 9.10.1. Without a matching asm, com.microsoft.java.test.plugin fails to
#   resolve, and it fails silently: no error reaches nvim, the vscode.java.test.*
#   commands simply never appear and test running does nothing.
#
#   The jars from Maven Central also need a manifest fix. They declare
#   Import-Package: org.objectweb.asm;version="9.9", and a bare version in OSGi
#   means [9.9,infinity), so they would wire straight back to jdtls's 9.10.1 and
#   recreate the conflict. This rewrites those imports to [9.9,9.10).
#
#   The 01- to 05- prefixes force install order. OSGi resolves each bundle as it
#   is installed, so a dependency listed after its dependent is too late.
#
# Safe to re-run. Delete the output directory if a future Mason update aligns
# the asm versions and these are no longer needed.

set -euo pipefail

DEST="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/jdtls-bundles"
ASM_VERSION="9.9"

mkdir -p "$DEST"
cd "$DEST"
rm -f ./*.jar

for artifact in asm asm-tree asm-analysis asm-commons asm-util; do
  echo "downloading $artifact-$ASM_VERSION.jar"
  curl -sfLO "https://repo.maven.apache.org/maven2/org/ow2/asm/$artifact/$ASM_VERSION/$artifact-$ASM_VERSION.jar"
done

python3 - "$ASM_VERSION" <<'PY'
import os, re, sys, zipfile

version = sys.argv[1]
order = {
    f"asm-{version}.jar": "01",
    f"asm-tree-{version}.jar": "02",
    f"asm-analysis-{version}.jar": "03",
    f"asm-commons-{version}.jar": "04",
    f"asm-util-{version}.jar": "05",
}
upper = "9.10"

def unfold(text):
    return re.sub(r"\r?\n ", "", text)

def fold(text):
    out = []
    for line in text.split("\n"):
        raw = line.encode()
        if len(raw) <= 72:
            out.append(line)
            continue
        out.append(raw[:72].decode())
        raw = raw[72:]
        while raw:
            out.append(" " + raw[:71].decode())
            raw = raw[71:]
    return "\n".join(out)

for name, prefix in order.items():
    src = zipfile.ZipFile(name)
    manifest = unfold(src.read("META-INF/MANIFEST.MF").decode())

    # Only Import-Package. Export-Package must keep a single version, not a range.
    def bound(match):
        body = re.sub(rf';version="{re.escape(version)}"', f';version="[{version},{upper})"', match.group(1))
        return "Import-Package: " + body

    patched = re.sub(r"Import-Package: (.*)", bound, manifest)

    tmp = name + ".tmp"
    out = zipfile.ZipFile(tmp, "w", zipfile.ZIP_DEFLATED)
    for item in src.infolist():
        data = src.read(item.filename)
        if item.filename == "META-INF/MANIFEST.MF":
            data = fold(patched).encode()
        out.writestr(item, data)
    out.close()
    src.close()

    os.replace(tmp, prefix + "-" + name)
    os.remove(name)
    print("patched", prefix + "-" + name)
PY

echo
echo "bundles ready in $DEST"
ls -1 "$DEST"
