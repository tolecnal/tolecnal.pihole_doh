#!/bin/bash

# Function to generate a random password
generate_password() {
    openssl rand -base64 24
}

# Step 1: Determine if passwords are provided as arguments
if [[ $# -eq 1 ]]; then
    webpass=$1
else
    # Generate random passwords
    webpass=$(generate_password)
fi

# Step 2: Store the generated passwords in .vault_pw
if [ -f .vault_pw ]; then
    echo "File already exists, doing nothing for vault_pw"
else
    touch .vault_pw
    vaultpw=$(generate_password)
    echo -e "$vaultpw" >.vault_pw
fi

# Step 4: Store the passwords in the file passwords.yml
if [ -f passwords.yml ]; then
    echo "File already exists, doing nothing for passwords.yml"
else
    ansible-vault encrypt_string --vault-password-file .vault_pw "$webpass" --name web_pass >>passwords.yml
fi

echo "Script completed successfully."
