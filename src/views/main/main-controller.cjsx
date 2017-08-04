CategoryThumbnailList = require './category-thumbnail-list'
ImageThumbnailList = require './image-thumbnail-list'
ImageFullView = require './image-full-view'
SideBar = require 'src/views/side-bar/side-bar'
CategoryStore = require 'src/stores/category-store'
GalleryStore = require 'src/stores/gallery-store'
ImageStore = require 'src/stores/image-store'
Location = require 'src/utils/location'
Tasks = require 'src/tasks/tasks'

class MainController extends Component
  
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
      return <span>Loading...</span>
    
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
    
    
module.exports = MainController.toComponent()
