CategoryStore = require 'src/stores/category-store'
ImageStore = require 'src/stores/image-store'
Tasks = require 'src/tasks/tasks'

class Location
  
  pathPrefix: '/'
  state: null
  deaf: false
  
  constructor: ->
    @state =
      category: null
      image: null
    
    @_addListeners()
    @_importLocationData()
  
  _addListeners: ->
    CategoryStore.on 'change', (=> @onStoreUpdate())
    ImageStore.on 'change', (=> @onStoreUpdate())
    window.onpopstate = ((e) => @onPopState(e))
  
  _importLocationData: ->
    parts = window.location.pathname.split '/'
    
    # Do an inverse loop of the path sections.
    for i in [parts.length-1..0] by -1
      part = parts[i]
      
      # If we encounter a number, assume it's an ID.
      if part.match /^[0-9]+$/
        
        # First number, we assume it's the category.
        unless @state.category
          @state.category = part
          continue;
        
        # Turns out we had two numbers, swap them.
        @state.image = @state.category
        @state.category = part
      
      # Other sections should be treated as a prefix.
      else if part.length > 1
        @pathPrefix = "/#{part}"+@pathPrefix
  
  getPath: (cat, img) ->
    @pathPrefix + (if cat then cat.id else "") + (if img then "/#{img.id}" else "")
  
  navigate: (cat, img) ->
    window.history.pushState @state, null, @getPath cat, img
  
  getStoreState: ->
    category: CategoryStore.getActive()
    image: ImageStore.getActive()
  
  getStateObjects: (state) ->
    category: if state.category then CategoryStore.getOne(state.category) else null
    image: if state.image then ImageStore.getOne(state.image) else null
  
  onPopState: (e) ->
    newState = @getStateObjects e.state
    @state.category = newState.category?.id
    @state.image = newState.image?.id
    
    # Update the stores, but ignore their changes.
    @deafen ->
      Tasks.locationChanged newState.category, newState.image
  
  onStoreUpdate: ->
    return if @deaf
    
    # Compare with current state for changes.
    newState = @getStoreState()
    if (newState.category?.id != @state.category) or (newState.image?.id != @state.image)
      
      # In case of changes, update state and push history.
      @state.category = newState.category?.id
      @state.image = newState.image?.id
      @navigate newState.category, newState.image
  
  deafen: (action) ->
    @deaf = true
    action()
    @deaf = false
  
module.exports = new Location
