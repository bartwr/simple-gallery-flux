Dispatcher = require 'src/utils/dispatcher'

class ImageStore extends FluxPlus.BaseStore
  entityName: 'images'

module.exports = new ImageStore(Dispatcher)