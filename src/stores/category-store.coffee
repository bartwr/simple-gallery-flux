import Dispatcher from '../utils/dispatcher'

class CategoryStore extends FluxPlus.BaseStore
  entityName: 'categories'

export default new CategoryStore(Dispatcher)
