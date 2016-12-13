toBackup() {
    local backup_dir="$1"
    shift
    
    # Clean Backup Dir
    rm -rf "$HOME/.dotfile.bak"
    mkdir "$HOME/.dotfile.bak"

    # Move files
    for file in "$@"; do
        if [ -f "$file" ]; then
            echo "Backup $file to $backup_dir"
            mv "$file" "$backup_dir/"
        fi
    done
}

#toBackup "$HOME/.dotfiles.bak" "$HOME/.bashrc" "$HOME/.bashrc.d" "$HOME/.bash_profile" "$HOME/.bash_profile.d"

mkdir -p "$HOME/.config" "$HOME/.bashrc.d" "$HOME/.bash_profile.d" 
install -pm 0644 -- bashrc "$HOME"/.bashrc
install -pm 0644 -- bashrc.d/* "$HOME"/.bashrc.d
install -pm 0644 -- bash_profile "$HOME"/.bash_profile
install -pm 0644 -- bash_profile.d/* "$HOME"/.bash_profile.d