import Dispatcher from '../utils/dispatcher'

class ImageStore extends FluxPlus.BaseStore
  entityName: 'images'

export default new ImageStore(Dispatcher)
