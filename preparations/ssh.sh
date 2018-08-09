#!/bin/sh
echo "Installing ssh keys"

mkdir ~/.ssh -p
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMnUuUJsXw9j27uRL2x7szuQ/EmbmSxl6MHPwzsBrI1YWc6l0LBjNW0YR/VzsnEWMR5oAlSTsTnKGQ1DoqRJwfjadQSLf/jFl/CBoZ+7LSC8kIfENIvxIeOoZTQw921OGTwcvR8e2KLWrQpAWTFaBmeI3ntECBX8soaumIusS4chOL0NDhk8OhbAIpJk5oPm7dpe8O3CG9QfLXhkJHlY60YyG3ZR+vVWn/7YaUMn0KLn+yxQsYBRs+/FnfXlVvIgThRTCK0HRAIVP3aa7SEOjGvN2BVe1B3GLCp00+keBK99d5kSuQ+pcD+rk7NIw0G/jZgKAhT/2clr3XGr2+lLml avin@avin-pc" >> ~/.ssh/authorized_keys
echo "$(uniq ~/.ssh/authorized_keys)" > ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

