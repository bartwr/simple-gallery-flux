import React, {Component} from 'react'
import Radium, {StyleRoot} from 'radium';

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
    CategoryStore.on 'change', @_onCategoryStoreChange.bind(@)
    GalleryStore.on 'change', @_onGalleryStoreChange.bind(@)
    ImageStore.on 'change', @_onImageStoreChange.bind(@)
    jQuery(document).bind 'keyup', this, @_onKeyPress.bind(@)
  
  componentWillUnmount: ->
    CategoryStore.off 'change', @_onCategoryStoreChange.bind(@)
    GalleryStore.off 'change', @_onGalleryStoreChange.bind(@)
    ImageStore.off 'change', @_onImageStoreChange.bind(@)
    jQuery(document).unbind 'keyup', @_onKeyPress.bind(@)
  
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
    <StyleRoot className="block thumbnail button" onClick={@_onNext.bind(@)}
      style={Object.assign({}, {backgroundImage: "url('#{nextImage.thumbnail}')"}, s.base)}>
      <div className="title-overlay"><i className="fa fa-chevron-right"></i></div>
    </StyleRoot>

s = {
  base: {
    '@media (max-width: 800px)': {
      display: 'none'
    }
  }
}

export default Radium(RightButtonController)
