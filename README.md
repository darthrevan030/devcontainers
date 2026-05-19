# Dev Container Templates

Personal dev container templates for use across projects. Published to `ghcr.io/darthrevan030/devcontainers`.

## Usage

1. Open a project in VS Code
2. `Ctrl+Shift+P` → "Add Dev Container Configuration Files"
3. Select "From a predefined container configuration template"
4. Enter `github.com/darthrevan030/devcontainers/{langauge}`
5. Pick your language

## Templates

| Template | Image | Includes |
|----------|-------|----------|
| `go` | `mcr.microsoft.com/devcontainers/go:1.26` | Claude Code, Docker-in-Docker, Firewall, PostgreSQL tools |
| `python` | `mcr.microsoft.com/devcontainers/python:3.14` | Claude Code, Docker-in-Docker, Firewall, PostgreSQL + SQLite tools |
| `node` | `mcr.microsoft.com/devcontainers/typescript-node:24.0` | Claude Code, Docker-in-Docker, Firewall, PostgreSQL + SQLite tools |
| `cpp` | `mcr.microsoft.com/devcontainers/cpp:ubuntu-24.04` | Claude Code, Firewall, CMake |

## Common Features

All templates include:
- **Claude Code** — AI coding assistant with persisted credentials from host
- **Firewall** — egress restricted to GitHub and Claude Code endpoints
- **Forwarded Ports** — 8080, 5432 (Go/Python/Node); none by default (C/C++)

## Notes

- Claude credentials are bind-mounted from `%USERPROFILE%\.claude` on the Windows host
- `postCreateCommand` fixes ownership so `vscode` user can access credentials
- Docker-in-Docker uses Docker CE (not Moby)
