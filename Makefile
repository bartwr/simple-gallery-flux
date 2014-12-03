install:
	npm install && bower install

update:
	npm install && bower update

xenv-simple-gallery:
	@gnome-terminal \
		--tab -t "FluxPlus builder" -e "./node_modules/.bin/gulp"
