## Nvim Config 

1. Download nvim

2. Create directory for config
```
mdkir -p ~/config/.nvim
```

3. Download in `~/config/.nvim`
```
git clone git@github.com:AppDevIn/nvim-config.git
```



## Java LSP

Java is the one language here that needs a manual step on a new machine. Everything
else Mason handles on its own.

### Prerequisites

A JDK 17 or newer, on `PATH`. `jdtls` is itself a Java application, so this is needed
to run the server, not just to analyse your code.

```
java -version
```

### 1. Build the asm bundles

```
./scripts/setup-jdtls-bundles.sh
```

Mason's `java-test` requires asm `[9.9,9.10)` while Mason's `jdtls` ships asm 9.10.1.
Without a matching asm the test plugin fails to load, and it fails silently: no error
reaches nvim, the `vscode.java.test.*` commands simply never appear and test running
does nothing at all. The script downloads asm 9.9 from Maven Central, patches its OSGi
manifests, and writes them to `~/.local/share/nvim/jdtls-bundles/`.

That directory lives outside this repo, so cloning alone is not enough. Run the script.

### 2. Start nvim

Mason installs `jdtls`, `java-debug-adapter` and `java-test` from `ensure_installed`
in `lua/plugins/lsp-config.lua`. Check progress with `:Mason`.

### 3. Open a Java file

The file must sit inside a project with a build file above it (`pom.xml`,
`build.gradle`, `mvnw`, `gradlew`, or `.git`). Without one, no server starts. With a
broken or empty one, jdtls reports `non-project file, only syntax errors are reported`
and gives no completion or classpath.

First open is slow. It boots a JVM and imports the project.

### Keymaps

| Key | Action |
| --- | --- |
| `<leader>db` | toggle breakpoint |
| `<leader>dc` | start or continue, offers each `main` class it finds |
| `<leader>tc` | run the test class in the current buffer |
| `<leader>tm` | run the nearest test method |

Test results print to the dap REPL (`<leader>du`) and failures go to the quickfix list.

### When something breaks

Read the log first. It names the real cause, which nvim never sees:

```
~/.cache/nvim/jdtls/workspace/<project>/.metadata/.log
```

There are three separate caches, and the one people miss is the third:

| Path | Holds |
| --- | --- |
| `~/.cache/nvim/jdtls/workspace/<project>` | the project index |
| `<project>/.classpath`, `.project`, `.settings/` | Eclipse's view of the build, safe to gitignore |
| `~/.local/share/nvim/mason/packages/jdtls/configuration/org.eclipse.osgi` | installed OSGi bundles |

That last one replays bundles at startup **before** `initialize` runs, so editing
`init_options.bundles` and restarting changes nothing until it is deleted:

```
rm -rf ~/.local/share/nvim/mason/packages/jdtls/configuration/org.eclipse.osgi
```

Quit every nvim before diagnosing. A second session keeps its own jdtls running
against the same workspace and interleaves its lines into the same log file.

If a future Mason update aligns the asm versions, `~/.local/share/nvim/jdtls-bundles/`
becomes dead weight and can be emptied.
