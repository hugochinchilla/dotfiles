dotfiles
========

Config files on my ~

```
cd ~ && \
  git clone --no-checkout git@github.com:hugochinchilla/dotfiles.git && \
  mv dotfiles/.git . && \
  rm -r dotfiles && \
  git reset --hard HEAD
```
