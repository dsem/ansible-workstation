# Ansible Playbook for Workstations

This repository contains an Ansible playbook to provision personal workstations

## Architecture Rules

This repo uses a flat, role-per-app architecture. Do
not create traditional Ansible directory structures (e.g., global
`group_vars`, shared `tasks/`, or complex role hierarchies).

1. **One Role Per App:** Every application/tool lives in its own directory inside `roles/`.
2. **Role Structure:** Roles contain at a minimum a `tasks/main.yml` file. If the
3. **Single Main Playbook:** All roles are explicitly called in the root playbook file (`site.yml` or `laptop.yml`).

---

## Pattern for Adding a New App/Tool

When asked to add a new app (e.g., `app_name`):

1. **Create Task Directory:** `roles/<app_name>/tasks/main.yml`
2. **Write Tasks:** Use appropriate package modules, but prefer
   platform-agnostic modules like `package` over `homebrew` or `dnf`.
3. **Unix Agnostic:** Always support running each role on MacOS and Linux,
   specifically Fedora. Do not try to support Windows.
4. **OS-specific Rules:** If a package requires several different tasks to be
   installed on Fedora vs MacOS, the OS-specific tasks should be in a
   `linux.yaml` or `macos.yml` file, respectively. The file should be called
   from `main.yml`. If only a single task or a small block of tasks are
   os-specific, use `when: os == 'macos'` or `when: os == `linux'` for the
   specific task or block.
5. **Register Role in Playbook:** Add `- role: <app_name>` to the `roles:` list
   in `./main.yml`.

### Example Task Template (`roles/<app_name>/tasks/main.yml`)
```yaml
---
- name: Install <app_name> package
  community.general.package:
    name: <package_name>
    state: present
  become: "{{ become_for_package }}"
```

### Example OS-Specific Task Template (`roles/app_name/tasks/main.yml`)
```yaml
---
- name: Include OS-specific tasks
  include_tasks: "{{ os }}.yml"
```

## Testing

After adding a role, run the following steps to test it:

1. Update the playbook to add a tag to the new role so it can be targeted with the `--tags` flag. for example:
   ```
  - role: <app_name>
    tags: this
   ```

2. Run the main playbook with the `--tags` flag:
   ```yaml
   ansible-playbook main.yml --tags this
   ```

3. When the play finishes successfully, test that the app can launch.

4. Remove the `tags: this` line from the new role in `main.yml`.
