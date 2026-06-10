# Dotfiles Repository Guidelines

## ⚠️ Security & Privacy (CRITICAL)

This repository is used to sync configurations across multiple machines and OS environments (Ubuntu, macOS) and may be pushed to public or shared remotes.

**UNDER NO CIRCUMSTANCES should you commit private or sensitive information into this repository.**

This includes, but is not limited to:
- API Keys (AWS, Google Cloud, OpenAI, GitHub, etc.)
- Personal Access Tokens (PATs)
- Passwords or Secret Phrases
- SSH Private Keys (`~/.ssh/id_rsa`, etc.)
- `.netrc` or `.pgpass` files containing credentials
- Any personal paths, specific IP addresses, or work-related secrets that should not be publicly exposed.

### How to handle secrets:
If a tool or script requires secret environment variables, configure them to be loaded from an external, untracked file (e.g., `~/.zshrc_secrets`) and explicitly add that file to `.gitignore`.

Example `~/.zshrc_common` setup:
```bash
# Load secrets if the file exists (DO NOT commit .zshrc_secrets)
if [ -f ~/.zshrc_secrets ]; then
    source ~/.zshrc_secrets
fi
```
