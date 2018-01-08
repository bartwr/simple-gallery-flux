import React, { Component } from 'react'
import Radium, {StyleRoot} from 'radium';

import CategoryThumbnailList from './category-thumbnail-list'
import ImageThumbnailList from './image-thumbnail-list'
import ImageFullView from './image-full-view'
import SideBar from '../side-bar/side-bar'
import CategoryStore from '../../stores/category-store'
import GalleryStore from '../../stores/gallery-store'
import ImageStore from '../../stores/image-store'
import Location from '../../utils/location'
import Tasks from '../../tasks/tasks'

class MainController extends Component
    
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
  
  componentWillUnmount: ->
    CategoryStore.off 'change', @_onCategoryStoreChange.bind(@)
    GalleryStore.off 'change', @_onGalleryStoreChange.bind(@)
    ImageStore.off 'change', @_onImageStoreChange.bind(@)
  
  sortCategories: (categories) ->
    return categories if categories == undefined

    Object.keys(categories).map(((key) ->
      categories[key]
    ), []).sort (a, b) ->
      return parseInt(a.lft) - parseInt(b.lft)

  _onGalleryStoreChange: ->
    @setState gallery: GalleryStore.getActive()

  _onCategoryStoreChange: ->
    @setState
      activeCategory: CategoryStore.getActive()
      categories: @sortCategories( CategoryStore.getAll() )
  
  _onImageStoreChange: ->
    @setState
      activeImage: ImageStore.getActive()
      images: ImageStore.getAll()
  
  _onOpenAlbums: ->
    Tasks.openAlbums()
  
  _onOpenCategory: (category) ->
    Tasks.openCategory category
  
  _onOpenImage: (image) ->
    Tasks.openImage image
  
  render: ->

    # Loading stage.
    unless @state.gallery and @state.categories and @state.images
      return <span>Loading ...</span>
    
    # Category list
    unless @state.activeCategory
      return <div style={s.flex}>
        <CategoryThumbnailList categories={@state.categories} images={@state.images} onClick={@_onOpenCategory.bind(@)} />
      </div>
    
    # Image list
    unless @state.activeImage
      return <div style={s.flex}>
        <StyleRoot onClick={() => document.location = '/gallery'} className="btn" style={Object.assign({}, s.back, {marginLeft: '15px', marginRight: '15px', marginBottom: '15px'})}>Terug naar albums</StyleRoot>
        <SideBar onOpenCategory={@_onOpenCategory.bind(@)} onOpenAlbums={@_onOpenAlbums.bind(@)} categories={@state.categories} activeCategory={@state.activeCategory} />
        <ImageThumbnailList category={@state.activeCategory} images={@state.images} onClick={@_onOpenImage.bind(@)} />
      </div>
    
    # Image full view
    <div style={s.flex}>
      <StyleRoot onClick={() => document.location = '/gallery'} className="btn" style={Object.assign({}, s.back)}>Terug naar albums</StyleRoot>
      <SideBar onLeftButtonClick={@_onOpenImage.bind(@)} onOpenCategory={@_onOpenCategory.bind(@)}
        onOpenAlbums={@_onOpenAlbums.bind(@)} categories={@state.categories} activeCategory={@state.activeCategory}
        images={@state.images} activeImage={@state.activeImage} />
      <ImageFullView image={@state.activeImage} category={@state.activeCategory} />
    </div>

s = {
  flex: {
    display: 'flex'
    justifyContent: 'space-between'
    flexFlow: 'row wrap',
  },
  back: {
    width: '100%',
    display: 'inline-block',
    marginTop: '15px'
    '@media(min-width: 801px)': {
      display: 'none'
    }
  }
}
    
export default Radium(MainController)
