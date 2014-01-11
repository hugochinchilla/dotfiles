dotfiles
========

Config files on my ~


Quick setup
-----------

```
cd ~ && \
  git clone --no-checkout git@github.com:hugochinchilla/dotfiles.git && \
  mv dotfiles/.git . && \
  rm -r dotfiles && \
  git reset --hard HEAD
```

Install oh-my-zsh

```
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
```
