---
name: add-role
description: Add a new app/tool role to the ansible-workstation playbook, following this repo's flat role-per-app structure with MacOS + Fedora support.
---

# Adding a New App/Tool Role

Use this skill whenever you're asked to add a new app or tool to the
workstation playbook.

## Steps

When asked to add a new app (e.g., `app_name`):

1. **Create Task Directory:** `roles/<app_name>/tasks/main.yml`
2. **Write Tasks:** Use appropriate package modules, but prefer
   platform-agnostic modules like `package` over `homebrew` or `dnf`.
3. **Unix Agnostic:** Always support running each role on macOS and Linux,
   specifically Fedora. Do not try to support Windows.
4. **OS-specific Rules:** If a package requires several different tasks to be
   installed on Fedora vs MacOS, put the OS-specific tasks in a `linux.yml` or
   `macos.yml` file under `tasks/`, and call it from `main.yml`. If only a
   single task or a small block of tasks are os-specific, use
   `when: os == 'macos'` or `when: os == 'linux'` for that specific task or
   block instead of splitting into separate files.
5. **Register Role in Playbook:** Add `- role: <app_name>` to the `roles:`
   list in `./main.yml`, keeping the list in alphabetical order.

## Example Task Template (`roles/<app_name>/tasks/main.yml`)

```yaml
---
- name: Install <app_name> package
  community.general.package:
    name: <package_name>
    state: present
  become: "{{ become_for_package }}"
```

## Example OS-Specific Task Template

`roles/<app_name>/tasks/main.yml`:

```yaml
---
- name: Include OS-specific tasks
  include_tasks: "{{ os }}.yml"
```

`roles/<app_name>/tasks/macos.yml` and `roles/<app_name>/tasks/linux.yml` then
each contain the OS-specific installation steps. See `roles/docker/` or
`roles/google-cloud-sdk/` for real examples of this split.

## Testing

After adding a role, run the following steps to test it:

1. Update the playbook to add a tag to the new role so it can be targeted
   with the `--tags` flag, for example:
   ```yaml
   - role: <app_name>
     tags: this
   ```

2. Run the main playbook with the `--tags` flag:
   ```bash
   ansible-playbook main.yml --tags this
   ```

3. When the play finishes successfully, test that the app can launch.

4. Remove the `tags: this` line from the new role in `main.yml`.
