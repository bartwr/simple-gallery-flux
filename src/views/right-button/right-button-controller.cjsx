import React, {Component} from 'react'
import CategoryStore from '../../stores/category-store'
import GalleryStore from '../../stores/gallery-store'
import ImageStore from '../../stores/image-store'
import Tasks from '../../tasks/tasks'

class RightButtonController extends Component
  
  constructor: ->
    @state = 
      activeCategory: null
      activeImage: null
      categories: null
      gallery: null
      images: null
    
  componentDidMount: ->
    CategoryStore.on 'change', @_onCategoryStoreChange
    GalleryStore.on 'change', @_onGalleryStoreChange
    ImageStore.on 'change', @_onImageStoreChange
    jQuery(document).bind 'keyup', this, @_onKeyPress
  
  componentWillUnmount: ->
    CategoryStore.off 'change', @_onCategoryStoreChange
    GalleryStore.off 'change', @_onGalleryStoreChange
    ImageStore.off 'change', @_onImageStoreChange
    jQuery(document).unbind 'keyup', @_onKeyPress
  
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
    if e.keyCode == 39
      e.data._onNext(e)
  
  _onNext: (e) ->
    return unless @state.activeCategory and @state.activeImage
    e.preventDefault()
    Tasks.openImage @getNextImage()
  
  render: ->
    return <div></div> unless @state.activeCategory and @state.activeImage
    
    nextImage = @getNextImage()
    <div className="block col1 thumbnail button" onClick={@_onNext}
      style={{backgroundImage: "url('#{nextImage.thumbnail}')"}}>
      <div className="title-overlay"><i className="fa fa-chevron-right"></i></div>
    </div>

export default RightButtonController
