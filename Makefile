NAME=dotfiles
VERSION=0.1
DESCRIPTION=nouchka's dotfiles
URL=https://github.com/nouchka/dotfiles
VENDOR=katagena
MAINTAINER=Jean-Avit Promis <docker@katagena.com>
LICENSE=Apache License 2.0

.DEFAULT_GOAL := build

deb:
	mkdir -p build/
	mkdir -p build/usr/share/
	mkdir -p build/usr/sbin/
	cp -Rf dist/home/ build/usr/share/dotfiles/
	cp -Rf dist/bin/nouchka-dotfiles build/usr/sbin/

build: deb
	rm -f $(NAME)_$(VERSION).$(TRAVIS_BUILD_NUMBER)_amd64.deb
	fpm -t deb -s dir -n $(NAME) -v $(VERSION).$(TRAVIS_BUILD_NUMBER) --description "$(DESCRIPTION)" -C build \
	--vendor "$(VENDOR)" -m "$(MAINTAINER)" --license "$(LICENSE)" --url $(URL) --deb-no-default-config-files \
	--replaces katagena-laptop \
	--replaces katagena-git \
	-d docker-ce -d firefox -d redshift -d gtk-redshift -d git-flow \
	-d openvpn -d network-manager-openvpn -d mosh -d openssh-server -d openssh-client \
	-d printer-driver-escpr -d gnome-session-flashback -d chromium-browser -d vlc -d unrar -d unzip -d samba -d ntp -d myspell-fr-fr \
	.
	rm -rf build/

push: build
	package_cloud push nouchka/home/ubuntu/xenial $(NAME)_*.deb

test:
	docker-compose up

down:
	docker-compose down
	rm -rf dotfiles*.deb

.PHONY: install
install:
	@chmod +x dist/bin/nouchka-dotfiles
	@dist/bin/nouchka-dotfiles
