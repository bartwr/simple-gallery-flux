import Dispatcher from '../utils/dispatcher'

class GalleryStore extends FluxPlus.BaseStore
  entityName: 'galleries'

export default new GalleryStore(Dispatcher)
