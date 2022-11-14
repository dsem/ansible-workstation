# Pixelbook

Roles and configurations specific to the Pixelbook running native linux.

There are three potential places to update:

- `/etc/systemd/logind.conf`
- `/etc/acpi/events/powerconf`
- Gnome Power Settings

For the Pixelbook, `/etc/systemd/logind.conf` didn't seem to make a difference.
The Ansible tasks for disabling the power button via logind have been left in
place and commented-out, in case they're useful on other devices.
