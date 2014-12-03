Dispatcher = require 'src/utils/dispatcher'

class GalleryStore extends FluxPlus.BaseStore
  entityName: 'galleries'

module.exports = new GalleryStore(Dispatcher)
