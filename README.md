dotfiles
========

Config files on my ~

Quick setup
-----------

Install zsh with oh-my-zsh first

```
sudo apt-get install -y zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
```

```
cd ~ && \
  git clone --no-checkout https://github.com/hugochinchilla/dotfiles.git && \
  mv dotfiles/.git . && \
  rm -r dotfiles && \
  git reset --hard HEAD \
  rm README.md \
  git update-index --assume-unchanged README.md
```

