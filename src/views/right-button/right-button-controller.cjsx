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
  
  componentWillUpdate: (newProps, newState) ->
    willBeActive = newState.activeCategory? and newState.activeImage?
    wasActive = @state.activeCategory? and @state.activeImage?
    
    if willBeActive and not wasActive
      jQuery(document).bind 'keypress', @_onKeyPress
    
    if not willBeActive and wasActive
      jQuery(document).unbind 'keypress', @_onKeyPress
  
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
  
  _onKeyPress: (e) ->
    if e.key == 'Right'
      ((e) => @_onNext(e))(e)
  
  _onNext: (e) ->
    e.preventDefault()
    Tasks.openImage @getNextImage()
  
  render: ->
    return <div></div> unless @state.activeCategory and @state.activeImage
    
    nextImage = @getNextImage()
    <div className="block col1 thumbnail button" onClick={@_onNext}
      style={{backgroundImage: "url('#{nextImage.thumbnail}')"}}>
      <div className="title-overlay"><i className="fa fa-chevron-right"></i></div>
    </div>

module.exports = RightButtonController.toComponent()
