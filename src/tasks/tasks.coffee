Api = require 'src/utils/api'
Dispatcher = require 'src/utils/dispatcher'
Action = FluxPlus.Action
ActionSource = FluxPlus.ActionSource
EntityOperation = FluxPlus.EntityOperation

module.exports =
  
  initializeGallery: (gallery, category, image) ->
    
    # Send the client action for this task.
    action = new Action
    action.name = "Tasks.initializeGallery"
    action.source = ActionSource.CLIENT
    Dispatcher.dispatch action
    
    # Get galleries with nested category data.
    Api.getGallery(gallery).then (result) ->
      action.entities.categories = EntityOperation.MERGE
      action.entities.galleries = EntityOperation.MERGE
      action.entities.images = EntityOperation.MERGE
      action.payload.categories = result.categories
      action.payload.galleries = [result.gallery]
      action.payload.images = result.images
      action.active.galleries = result.gallery
      
      # Find the active category by ID, if needed.
      if category
        for categoryObj in action.payload.categories
          if category.toString() == categoryObj.id.toString()
            action.active.categories = categoryObj
            break
      
      # Find the active image by ID, if needed.
      if image
        for imageObj in action.payload.images
          if image.toString() == imageObj.id.toString()
            action.active.images = imageObj
            break
      
      # Send the server action for this task.
      action.source = ActionSource.SERVER
      Dispatcher.dispatch action
  
  openAlbums: ->
    
    # Send the client action for this task.
    action = new Action
    action.name = "Tasks.openAlbums"
    action.source = ActionSource.CLIENT
    action.active.categories = null
    action.active.images = null
    Dispatcher.dispatch action
    
  openCategory: (category) ->
    
    # Send the client action for this task.
    action = new Action
    action.name = "Tasks.openCategory"
    action.source = ActionSource.CLIENT
    action.active.categories = category
    action.active.images = null
    Dispatcher.dispatch action

  openImage: (image) ->
    
    # Send the client action for this task.
    action = new Action
    action.name = "Tasks.openImage"
    action.source = ActionSource.CLIENT
    action.active.images = image
    Dispatcher.dispatch action
  
  locationChanged: (category, image) ->
    
    # Send the client action for this task.
    action = new Action
    action.name = "Tasks.locationChanged"
    action.source = ActionSource.CLIENT
    action.active.categories = category
    action.active.images = image
    Dispatcher.dispatch action
