Dispatcher = require '../utils/dispatcher'

class CategoryStore extends FluxPlus.BaseStore
  entityName: 'categories'

module.exports = new CategoryStore(Dispatcher)
