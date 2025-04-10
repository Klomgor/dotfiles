# GitHub Configuration

This directory contains GitHub-specific configuration for this dotfiles repository.

## Workflows

### `security-checks.yml`

This workflow performs several automated checks to ensure the security and quality of the dotfiles:

1. **Security Scanning**: 
   - Uses GitLeaks to detect potential secrets in the codebase
   - Uses TruffleHog to detect potential secrets using entropy analysis

2. **Linting**:
   - Uses GitHub Super-Linter to validate code quality and style
   - Validates YAML, JSON, Markdown, Bash, and Zsh files

3. **Chezmoi Configuration Test**:
   - Verifies that the chezmoi configuration is valid
   - Performs a dry run of chezmoi init and apply
   - Outputs the chezmoi data for debugging

4. **Notifications**:
   - Creates a GitHub issue if any job fails

## Triggers

The workflow runs:

- On every push to the main branch
- On every pull request to the main branch
- Daily at 7:00 AM UTC
- Manually when triggered via the GitHub Actions UI 