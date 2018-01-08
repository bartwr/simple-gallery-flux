import Api from 'src/utils/api'
import Dispatcher from 'src/utils/dispatcher'
Action = FluxPlus.Action
ActionSource = FluxPlus.ActionSource
EntityOperation = FluxPlus.EntityOperation

export default
  
  initializeGallery: (gallery, category, image) ->
    
    # Send the client action for this task.
    action = new Action
    action.name = "SimpleGalleryTasks.initializeGallery"
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
      if category?
        for categoryObj in action.payload.categories
          action.active.categories = categoryObj if category is categoryObj.id
      
      # Find the active image by ID, if needed.
      if image?
        for imageObj in action.payload.images
          action.active.images = imageObj if image is imageObj.id

      # Send the server action for this task.
      action.source = ActionSource.SERVER
      Dispatcher.dispatch action
