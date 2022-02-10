install:
	sudo echo "Install..."

	mkdir ~/moulinette
	mkdir ~/moulinette/build
	cp -r .build/tests ~/moulinette/build/
	cp -r .build/mouli.sh ~/moulinette/build/

	git clone https://github.com/ronanboiteau/NormEZ
	mv NormEZ/ ~/moulinette/
	make -C ~/moulinette/NormEZ/ install

	python3 -m pip install pycparser pyparsing pycparser-fake-libc --user
	sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/aureliancnx/Bubulle-Norminette/master/install_bubulle.sh)"

	echo -e "\nalias addmouli='cp -r ~/moulinette/build/tests $PWD && cp ~/moulinette/build/mouli.sh $PWD'" >> ~/.bashrc
	echo -e "\nalias addmouli='cp -r ~/moulinette/build/tests $PWD && cp ~/moulinette/build/mouli.sh $PWD'" >> ~/.zshrc

	echo -e "Succesfully installed."

uninstall:
	echo -e "Uninstall... "
	rm -r ~/moulinette
	echo -e "Succesfully uninstalled."