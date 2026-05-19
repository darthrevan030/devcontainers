# Dev Container Templates

Personal dev container templates for use across projects. Published to `ghcr.io/darthrevan030/devcontainers`.

## Usage

1. Open a project in VS Code
2. `Ctrl+Shift+P` → "Add Dev Container Configuration Files"
3. Select "From a predefined container configuration template"
4. Enter `ghcr.io/darthrevan030/devcontainers/{language}`
5. Pick your language

## Templates

| Template | Image | Includes |
| ---------- | ------- | ---------- |
| `go` | `mcr.microsoft.com/devcontainers/go:1.26` | Claude Code, Docker-in-Docker, Firewall, PostgreSQL tools |
| `python` | `mcr.microsoft.com/devcontainers/python:3.14` | Claude Code, Docker-in-Docker, Firewall, PostgreSQL + SQLite tools |
| `node` | `mcr.microsoft.com/devcontainers/typescript-node:24.0` | Claude Code, Docker-in-Docker, Firewall, PostgreSQL + SQLite tools |
| `cpp` | `mcr.microsoft.com/devcontainers/cpp:ubuntu-24.04` | Claude Code, Firewall, CMake |

## Common Features

All templates include:

- **Claude Code** — AI coding assistant with credentials bind-mounted from the Windows host
- **Firewall** — egress restricted to GitHub and Claude Code endpoints only
- **Docker-in-Docker** — Docker CE (not Moby), available in all templates

## Forwarded Ports

| Template | Ports |
| ---------- | ------- |
| Go | 8080, 5432 |
| Python | 8080, 5432 |
| Node/TS | 3000, 5173, 8080, 5432 |
| C/C++ | — |

## Notes

- Claude credentials are bind-mounted from `%USERPROFILE%\.claude` on the Windows host
- `postCreateCommand` runs `chown` to transfer ownership to the `vscode` user so credentials are accessible
- `go mod tidy`, `pip install`, and `npm install` run automatically on container creation if the relevant dependency file exists
- To update a template, edit the config and push to `main` — GitHub Actions republishes to `ghcr.io` automatically
