# Ansible Playbook for Workstations

This repository contains an Ansible playbook to provision personal
workstations, supporting both macOS and Fedora Linux.

## Architecture Rules

This repo uses a flat, role-per-app architecture. Do not create traditional
Ansible directory structures (e.g., global `group_vars`, shared `tasks/`, or
complex role hierarchies).

1. **One Role Per App:** Every application/tool lives in its own directory
   inside `roles/`.
2. **Role Structure:** Roles contain at a minimum a `tasks/main.yml` file.
3. **Single Main Playbook:** All roles are explicitly called in the root
   playbook file (`main.yml`).

## Repo Layout

- `main.yml` — the root playbook; the `roles:` list registers every role that
  should run.
- `roles/<app_name>/` — one directory per app/tool, each an independent
  Ansible role.
- `group_vars/`, `host_vars/` — variables scoped to the whole play or a
  specific host (kept minimal per the flat architecture above).
- `pre.yml`, `bootstrap-remote.yml`, `debug.yml` — supporting playbooks for
  bootstrapping and debugging.

## Adding a New Role

See the `add-role` skill in `.agents/skills/add-role/SKILL.md` for the
step-by-step pattern, file templates, and testing procedure for adding a new
app/tool role.
