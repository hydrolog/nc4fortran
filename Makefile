all:	install_fpm

install:	install_fpm

install_fpm:
	bash ./install.sh

test: test_fpm

test_fpm:
	bash ./test.sh

clean:
	rm -rf ./lib; rm -rf ./include; rm -rf ./build


