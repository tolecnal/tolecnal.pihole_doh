# ansible-role-tmux

Deploy and configure Oh My Zsh with the Powerlevel 10K theme

## Requirements

None

## Role variables

Available variables are listed below, along with the default values (see: `defaults/main.yml`)

---

    ohmyzsh_users: []

List of the users to run the role on.

    ohmyzsh_chsh: true

Change the default shell to zsh?

    ohmyzsh_zsh_path: "/bin/zsh"

The path to the zsh binary.

    ohmyzsh_theme: "powerlevel10k/powerlevel10k"

The theme to define in .zshrc

    ohmyzsh_case_sensitive_completion: false

Enable case sensitive completion?

    ohmyzsh_hyphen_insensitive_completion: false

Enable hyphen insensitive completion?

    ohmyzsh_disable_auto_update: false

Disable auto update of oh-my-zsh?

    ohmyzsh_auto_update_interval: 30

The interval oh-my-zsh will check for updates.

    ohmyzsh_disable_ls_colors: false

Disable colours for `ls`?

    ohmyzsh_disable_auto_title: false

Disable oh-my-zsh's auto title feature?

    ohmyzsh_enable_auto_correction: true

Enable oh-my-zsh's auto correction feature?

    ohmyzsh_completion_waiting_dots: true

Enable the waiting dots for autocomplete feature?

    ohmyzsh_history_stamps: "yyyy-mm-dd"

Timestamp format to use for the `.zsh_history` file.

    ohmyzsh_plugins: "autoupdate colored-man-pages docker docker-compose git history history-substring-search kubectl nmap pip python rsync systemd tmux ubuntu vagrant vi-mode aws terraform"

Which plugins to enable.

    ohmyzsh_autosuggestions_plugin: true

Enable the autosuggestions feature?

    ohmyzsh_language: "en_US.UTF-8"

Language to set for both `LANG` and `LANGUAGE`.

## Dependencies

None

## Example playbook

First install the role using Ansible Galaxy: `ansible-galaxy role install tolecnal.ohmyzsh`

Then create a playbook like this, replace `ohmyzsh_users` with the user(s) you want to run the role on.

    ---
    
    - name: Run tolecnal.ohmyzsh role
      hosts: all
      become: true
      gather_facts: true

      vars:
        ohmyzsh_users: tolecnal

      roles:
        - tolecnal.ohmyzsh

## License

MIT / BSD

## Author information

Jostein Elvaker Haande - tolecnal - [tolecnal.net](https://tolecnal.net)
