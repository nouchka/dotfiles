# dotfiles

Personal dotfiles

```
curl -L https://packagecloud.io/nouchka/home/gpgkey | sudo apt-key add -
echo "deb https://packagecloud.io/nouchka/home/ubuntu/ xenial main" > /etc/apt/sources.list.d/nouchka_home.list
apt-get update && apt-get install dotfiles
nouchka-dotfiles
```
