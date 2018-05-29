NAME=dotfiles
BINARY=/usr/sbin/weave
VERSION=0.1
DESCRIPTION=My dotfiles
URL=https://github.com/nouchka/dotfiles
VENDOR=katagena
MAINTAINER=Jean-Avit Promis <docker@katagena.com>
LICENSE=Apache License 2.0

.DEFAULT_GOAL := build

deb:
	mkdir -p `dirname dist$(BINARY)`
	touch dist$(BINARY)
	chmod 0755 dist$(BINARY)

build: deb
	rm -f $(NAME)_$(VERSION).$(TRAVIS_BUILD_NUMBER)_amd64.deb
	fpm -t deb -s dir -n $(NAME) -v $(VERSION).$(TRAVIS_BUILD_NUMBER) --description "$(DESCRIPTION)" -C dist \
	--vendor "$(VENDOR)" -m "$(MAINTAINER)" --license "$(LICENSE)" --url $(URL) \
	--deb-no-default-config-files .

push: build
	package_cloud push nouchka/home/ubuntu/xenial $(NAME)_*.deb
