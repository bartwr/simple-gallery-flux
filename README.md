# Simple gallery flux

Outdoor medicine version.

## Required on live setup

First install and build locally.

```sh
npm install && bower install && ./node_modules/.bin/gulp build
```

Then copy (at least) these files to the server.

* `bower_components/*`
* `dist/*`
* `plugin.php`

## Develop

Always:

	gulp -w 

First time:

	npm install && bower install && npm install -g gulp && gulp -w
