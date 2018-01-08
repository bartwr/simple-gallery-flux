import React, { Component } from 'react'

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
    console.log('_onGalleryStoreChange')
    @setState gallery: GalleryStore.getActive()

  _onCategoryStoreChange: ->
    console.log('_onCategoryStoreChange')
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

    console.log @state

    # Loading stage.
    unless @state.gallery and @state.categories and @state.images
      return <span>Loading ...</span>
    
    # Category list
    unless @state.activeCategory
      return <div>
        <CategoryThumbnailList categories={@state.categories} images={@state.images} onClick={@_onOpenCategory.bind(@)} />
      </div>
    
    # Image list
    unless @state.activeImage
      console.log('Image List')
      return <div>
        <SideBar onOpenCategory={@_onOpenCategory.bind(@)} onOpenAlbums={@_onOpenAlbums.bind(@)} categories={@state.categories} activeCategory={@state.activeCategory} />
        <ImageThumbnailList category={@state.activeCategory} images={@state.images} onClick={@_onOpenImage.bind(@)} />
      </div>
    
    # Image full view
    console.log('MainController: Image full view')
    <div>
      <SideBar onLeftButtonClick={@_onOpenImage.bind(@)} onOpenCategory={@_onOpenCategory.bind(@)}
        onOpenAlbums={@_onOpenAlbums.bind(@)} categories={@state.categories} activeCategory={@state.activeCategory}
        images={@state.images} activeImage={@state.activeImage} />
      <ImageFullView image={@state.activeImage} category={@state.activeCategory} />
    </div>
    
export default MainController
