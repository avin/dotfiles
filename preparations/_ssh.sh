#!/usr/bin/env bash
set -e

SSH_DIR="$HOME/.ssh"
AUTH_KEYS="$SSH_DIR/authorized_keys"
PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMnUuUJsXw9j27uRL2x7szuQ/EmbmSxl6MHPwzsBrI1YWc6l0LBjNW0YR/VzsnEWMR5oAlSTsTnKGQ1DoqRJwfjadQSLf/jFl/CBoZ+7LSC8kIfENIvxIeOoZTQw921OGTwcvR8e2KLWrQpAWTFaBmeI3ntECBX8soaumIusS4chOL0NDhk8OhbAIpJk5oPm7dpe8O3CG9QfLXhkJHlY60YyG3ZR+vVWn/7YaUMn0KLn+yxQsYBRs+/FnfXlVvIgThRTCK0HRAIVP3aa7SEOjGvN2BVe1B3GLCp00+keBK99d5kSuQ+pcD+rk7NIw0G/jZgKAhT/2clr3XGr2+lLml avin@avin-pc"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

# Add public key if it does not exist
if ! grep -qxF "$PUBLIC_KEY" "$AUTH_KEYS" 2>/dev/null; then
  echo "$PUBLIC_KEY" >> "$AUTH_KEYS"
fi

chmod 600 "$AUTH_KEYS"