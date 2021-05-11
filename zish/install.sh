#!/bin/sh

# Check dependencies
zsh --version > /dev/null || {
  echo 'zsh is not installed. Please make sure it is correctly installed on your system. A list on how to install it on many distributions can be found here: https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#how-to-install-zsh-on-many-platforms'
  exit 127
}

wget --version > /dev/null || {
  curl --version > /dev/null || {
    echo 'You have neither wget nor curl installed. Please install at least one of them.'
    exit 127
  }
}

git --version > /dev/null || {
  echo 'git is not installed. Please make sure it is correctly installed on your system.'
  exit 127
}

# Install Oh My Zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || exit 1
}

# Install necessary plugins
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions || exit 1
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search || exit 1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting || exit 1

# Install theme
wget https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/zish/zish.zsh-theme || {
  curl https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/zish/zish.zsh-theme || exit 1
}
mv zish.zsh-theme ~/.oh-my-zsh/custom/ || exit 1

# Apply plugins
perl -i -p -e 's/^(plugins=\(.*?)\)/\1 zsh-autosuggestions history-substring-search zsh-syntax-highlighting)/g' ~/.zshrc || exit 1

# Set theme
perl -i -p -e 's/^ZSH_THEME.*$/ZSH_THEME="zish"/g' ~/.zshrc || exit 1
echo "ZSH_AUTOSUGGEST_STRATEGY=(history completion)" >> ~/.zshrc || exit 1

echo "ZSH_HIGHLIGHT_STYLES[arg0]=fg=4" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[command]=fg=4" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[alias]=fg=4" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=4" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[precommand]=fg=4,bold" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[builtin]=fg=6,bold" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[default]=fg=12" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[path]=fg=12" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=5" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=208,bold" >> ~/.zshrc || exit 1
echo "ZSH_HIGHLIGHT_STYLES[assign]=fg=14" >> ~/.zshrc || exit 1


echo "Installation finished. You can set zsh as your default shell using 'chsh -s (\$which zsh)'"

