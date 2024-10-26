# Naming Convention Guidelines

## Introduction

This document outlines the naming conventions to be followed for files and directories in this repository. Consistent naming conventions help maintain clarity, organization, and ease of use.

## General Rules

1. **Use lowercase letters**: All file and directory names should be in lowercase letters.
2. **Use hyphens instead of underscores**: Use hyphens (`-`) to separate words in file and directory names. Avoid using underscores (`_`).
3. **Avoid special characters**: Do not use special characters (e.g., `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `(`, `)`, `+`, `=`, `{`, `}`, `[`, `]`, `|`, `\`, `:`, `;`, `"`, `'`, `<`, `>`, `,`, `?`, `/`) in file and directory names.
4. **Be descriptive**: Choose names that clearly describe the content or purpose of the file or directory.
5. **Use consistent naming patterns**: Follow a consistent pattern for similar types of files and directories.

## Examples

### Configuration Files

- Good: `gitconfig`, `zshrc`, `chezmoi.toml`
- Bad: `GitConfig`, `ZSHRC`, `chezmoi_config.toml`

### Scripts

- Good: `install-dependencies.sh`, `backup-files.sh`
- Bad: `installDependencies.sh`, `backupFiles.sh`

### Directories

- Good: `scripts`, `config`, `docs`
- Bad: `Scripts`, `Config`, `Docs`

## Best Practices

1. **Review existing files**: Before adding a new file or directory, review the existing files to ensure consistency with the established naming conventions.
2. **Refactor when necessary**: If you come across files or directories that do not adhere to the naming conventions, take the time to rename them and update any references.
3. **Automate validation**: Use tools like pre-commit hooks or continuous integration (CI) pipelines to automatically check for naming convention violations.

## Conclusion

Following these naming conventions will help maintain a well-organized and easily navigable repository. Consistency is key to ensuring that all contributors can quickly understand and work with the files and directories in the repository.
