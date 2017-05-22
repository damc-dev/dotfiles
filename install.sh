# Copy files to ~/
for file in $HOME/dotfiles/copy/* do
  cp "$HOME/dotfiles/copy/$file" ~/
done

# Symnlink files to ~/
for file in $HOME/dotfiles/link/* do
  ln -sf "$HOME/dotfiles/copy/$file" ~/$file
done

# Symnlink bin files
ln -fs "$HOME/dotfiles/bin" ~/

# Make bin files executable
for file in $HOME/bin/* do
    chmod +x "$HOME/bin/$file"
done
