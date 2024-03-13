#!/bin/bash

# Function to generate a random password
generate_password() {
    openssl rand -base64 24
}

# Step 1: Create a file named .vault_pw
touch .vault_pw

# Step 2: Determine if passwords are provided as arguments
if [[ $# -eq 2 ]]; then
    webpass=$1
    piholepass=$2
else
    # Generate random passwords
    webpass=$(generate_password)
    piholepass=$(generate_password)
fi

vaultpw=$(generate_password)

# Step 3: Store the generated passwords in .vault_pw
if [ -f .vault_pw ]; then
    echo "File already exists, doing nothing for vault_pw"
else
    echo -e "$vaultpw" >.vault_pw
fi

# Step 4: Store the passwords in the file passwords.yml
if [ -f passwords.yml ]; then
    echo "File already exists, doing nothing for passwords.yml"
else
    ansible-vault encrypt_string --vault-password-file .vault_pw "$webpass" --name WEBPASS >>passwords.yml
    ansible-vault encrypt_string --vault-password-file .vault_pw "$piholepass" --name PIHOLEPASS >>passwords.yml
fi

echo "Script completed successfully."
