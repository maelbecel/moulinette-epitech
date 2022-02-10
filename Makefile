install:
	sudo echo "Install..."

	echo "Create dir..."
	mkdir ~/moulinette
	mkdir ~/moulinette/build

	echo "Move dir..."
	cp -r .build/tests ~/moulinette/build/
	cp -r .build/mouli.sh ~/moulinette/build/

	echo "Add normez..."
	git clone https://github.com/ronanboiteau/NormEZ
	mv NormEZ/ ~/moulinette/
	sudo make -C ~/moulinette/NormEZ/ install

	echo "Add Bubulle..."
	python3 -m pip install pycparser pyparsing pycparser-fake-libc --user
	sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/aureliancnx/Bubulle-Norminette/master/install_bubulle.sh)"

	echo "Add aliases..."
	echo "alias addmouli='cp -r ~/moulinette/build/tests/ . && cp ~/moulinette/build/mouli.sh .'" >> ~/.bashrc
	echo "alias addmouli='cp -r ~/moulinette/build/tests/ . && cp ~/moulinette/build/mouli.sh .'" >> ~/.zshrc

	echo "Succesfully installed."

uninstall:
	echo "Uninstall... "
	sudo make -C ~/moulinette/NormEZ/ uninstall
	yes | rm -r ~/moulinette
	echo "Succesfully uninstalled."