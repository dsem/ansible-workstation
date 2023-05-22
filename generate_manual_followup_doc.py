"""
Pre-commit script that generates the MANUAL_FOLLOWUPS.md file with the contents
of the Manual Follow sections of each role's README.
"""

import os


class RoleReadme:
    _readme_lines: list|None = None
    _role_name: str|None = None
    _start_index: int|None = None
    _end_index: int|None = None

    def __init__(self, readme: str):
        self.readme = readme

    @property
    def readme_lines(self) -> list:
        if self._readme_lines is None:
            with open(self.readme, "r") as file_:
                self._readme_lines = file_.readlines()

        return self._readme_lines

    @property
    def role_name(self):
        if self._role_name is None:
            for line in self.readme_lines:
                if line.startswith("# "):
                    self._role_name = line.lstrip("# ").rstrip()
                    break
            else:
                self._role_name = ""
        return self._role_name

    @property
    def start_index(self) -> int:
        if self._start_index is None:
            for n, line in enumerate(self.readme_lines):
                if line.strip() == "## Manual Followup":
                    self._start_index = n
                    break
            else:
                self._start_index = -1

        return self._start_index

    @property
    def end_index(self) -> int:
        if self._end_index is None:
            for n, line in enumerate(self.readme_lines[self.start_index]):
                if line.startswith("## "):
                    self._end_index = n + self.start_index
                    break
            else:
                self._end_index = -1

        return self._end_index

    @property
    def manual_followup_section(self) -> str:
        if self.start_index != -1:
            if self.end_index == -1:
                return "".join(self.readme_lines[self.start_index + 1:]).strip()
            else:
                return "".join(self.readme_lines[self.start_index + 1:self.end_index]).strip()
        return ""


def glob_for_readmes() -> list:
    readmes = []
    for root, _, files in os.walk("."):
        for file in files:
            if file == "README.md":
                readmes.append(os.path.join(root, file))
    return readmes


def main():
    output_file = "MANUAL_FOLLOWUPS.md"  # Name of the output file
    readme_files = glob_for_readmes()

    followup_section = (
        "# Manual Followups\n\nAfter running the playbook for the first time on "
        "a new workstation, follow these steps to finish setting everything "
        "up.")

    # Iterate through each README file and parse its content
    for file_path in readme_files:
        role_readme = RoleReadme(file_path)
        if role_readme.manual_followup_section:
            followup_section += (
                f"\n\n\n"
                f"## {role_readme.role_name}\n\n"
                f"{role_readme.manual_followup_section}")

    # Write the combined content to the output file
    with open(output_file, 'w', encoding='utf-8') as file:
        file.write(followup_section)


if __name__ == '__main__':
    main()

