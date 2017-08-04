VideoThumbnailListItem = require './video-thumbnail-list-item'
ImageThumbnailListItem = require './image-thumbnail-list-item'

class ImageThumbnailList extends Component
  
  render: ->
    
    @props = @props

    # Images of this category only.
    items = []

    if @props.category.images
      for id in @props.category.images
        image = @props.images[id]
        items.push <ImageThumbnailListItem key={id} image={image} onClick={@props.onClick} />
    
    <div className="image-thumbnail-list">
      <div className="block col1 title">{@props.category.title}</div>
      {items}
    </div>

module.exports = ImageThumbnailList.toComponent()
