CategoryStore = require 'src/stores/category-store'
GalleryStore = require 'src/stores/gallery-store'
ImageStore = require 'src/stores/image-store'
Tasks = require 'src/tasks/tasks'

class RightButtonController extends Component
  
  componentDidMount: ->
    CategoryStore.on 'change', @_onCategoryStoreChange
    GalleryStore.on 'change', @_onGalleryStoreChange
    ImageStore.on 'change', @_onImageStoreChange
  
  componentWillUnmount: ->
    CategoryStore.off 'change', @_onCategoryStoreChange
    GalleryStore.off 'change', @_onGalleryStoreChange
    ImageStore.off 'change', @_onImageStoreChange
  
  getInitialState: ->
    activeCategory: null
    activeImage: null
    categories: null
    gallery: null
    images: null
  
  getNextImage: ->
    currentIndex = @state.activeCategory.images.indexOf(parseInt(@state.activeImage.id, 10))
    nextIndex = (currentIndex+1) % @state.activeCategory.images.length
    nextImage = @state.images[@state.activeCategory.images[nextIndex]]
  
  _onGalleryStoreChange: ->
    @setState gallery: GalleryStore.getActive()
  
  _onCategoryStoreChange: ->
    @setState
      activeCategory: CategoryStore.getActive()
      categories: CategoryStore.getAll()
  
  _onImageStoreChange: ->
    @setState
      activeImage: ImageStore.getActive()
      images: ImageStore.getAll()
  
  _onClick: (e) ->
    e.preventDefault()
    Tasks.openImage @getNextImage()
  
  render: ->
    return <div></div> unless @state.activeCategory and @state.activeImage
    
    nextImage = @getNextImage()
    <div className="block col1 thumbnail button" onClick={@_onClick}
      style={{backgroundImage: "url('#{nextImage.thumbnail}')"}}>
      <div className="title-overlay">&gt;</div>
    </div>

module.exports = RightButtonController.toComponent()
