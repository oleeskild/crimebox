# Code as a Crime Scene Workshop

This repository contains a dev container setup for the "Code as a Crime Scene" workshop. The container comes pre-configured with all the tools needed for the workshop.

## Prerequisites

- [Docker](https://www.docker.com/products/docker-desktop)
- [Visual Studio Code](https://code.visualstudio.com/)
- [VS Code Remote - Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## What's Included

- Java 17 (OpenJDK)
- Code-Maat tool
- Cloc (Count Lines of Code)
- Maat-scripts repository (located at `/workspace/maat-scripts`)

## Getting Started

1. Clone this repository
2. Open the repository in VS Code
3. VS Code will prompt you to reopen in a container, click "Reopen in Container"
   - Alternatively, you can click the green button in the bottom-left corner of VS Code and select "Reopen in Container"
4. Wait for the container to build and start

## Using the Tools

### Code-Maat

Code-Maat is available directly in your PATH. You can run it using:

```bash
code-maat -h
```

### Cloc

Count lines of code with:

```bash
cloc <directory-or-file>
```

### Maat-Scripts

The maat-scripts repository is cloned to `/workspace/maat-scripts`. You can navigate to it and use the scripts:

```bash
cd /workspace/maat-scripts
# Run scripts as needed
```

## Workshop Resources

For more information about "Code as a Crime Scene" techniques, check out:

- [Your Code as a Crime Scene](https://pragprog.com/titles/atcrime/your-code-as-a-crime-scene/) by Adam Tornhill
- [Code-Maat GitHub Repository](https://github.com/adamtornhill/code-maat)
- [Maat-Scripts GitHub Repository](https://github.com/adamtornhill/maat-scripts)
