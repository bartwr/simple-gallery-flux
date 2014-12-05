CategoryThumbnailListItem = require './category-thumbnail-list-item'

class CategoryThumbnailList extends Component
  
  render: ->
    
    # Collect category thumbnails.
    items = []
    for id, item of @props.categories
      
      # Use the first image as category thumbnail.
      image = @props.images[ item.images[0] ]
      
      items.push <CategoryThumbnailListItem key={id} category={item} image={image} onClick={@props.onClick} />
    
    <div className="category-thumbnail-list">{items}</div>

module.exports = CategoryThumbnailList.toComponent()
