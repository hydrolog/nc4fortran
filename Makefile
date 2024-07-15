all:	install_fpm

install:	install_fpm

install_fpm:
	bash ./install.sh

clean:
	rm -rf ./lib; rm -rf ./include; rm -rf ./build


