import React, { Component } from 'react'

import CategoryThumbnailList from './category-thumbnail-list'
import ImageThumbnailList from './image-thumbnail-list'
import ImageFullView from './image-full-view'
import SideBar from '../../views/side-bar/side-bar'
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
    CategoryStore.on 'change', @_onCategoryStoreChange
    GalleryStore.on 'change', @_onGalleryStoreChange
    ImageStore.on 'change', @_onImageStoreChange
  
  componentWillUnmount: ->
    CategoryStore.off 'change', @_onCategoryStoreChange
    GalleryStore.off 'change', @_onGalleryStoreChange
    ImageStore.off 'change', @_onImageStoreChange
  
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

    console.log @state

    # Loading stage.
    unless @state.gallery and @state.categories and @state.images
      return <span>Loading ...</span>
    
    # Category list
    unless @state.activeCategory
      return <div>
        <CategoryThumbnailList categories={@state.categories} images={@state.images} onClick={@_onOpenCategory} />
      </div>
    
    # Image list
    unless @state.activeImage
      return <div>
        <SideBar onOpenCategory={@_onOpenCategory} onOpenAlbums={@_onOpenAlbums}
          categories={@state.categories} activeCategory={@state.activeCategory} />
        <ImageThumbnailList category={@state.activeCategory} images={@state.images} onClick={@_onOpenImage} />
      </div>
    
    # Image full view
    <div>
      <SideBar onLeftButtonClick={@_onOpenImage} onOpenCategory={@_onOpenCategory}
        onOpenAlbums={@_onOpenAlbums} categories={@state.categories} activeCategory={@state.activeCategory}
        images={@state.images} activeImage={@state.activeImage} />
      <ImageFullView image={@state.activeImage} category={@state.activeCategory} />
    </div>
    
export default MainController
