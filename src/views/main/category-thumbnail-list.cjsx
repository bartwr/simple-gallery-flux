CategoryThumbnailListItem = require './category-thumbnail-list-item'

class CategoryThumbnailList extends Component
  
  render: ->
    
    # Collect category thumbnails.
    items = []
    for id, item of @props.categories
      
      # Use the first image as category thumbnail.
      image = if item.images then @props.images[ item.images[0] ] else ''
 
      items.push <CategoryThumbnailListItem key={id} category={item} image={image} onClick={@props.onClick} />
    
    <div className="category-thumbnail-list">
      <div className="block col1 title">Albums</div>
      {items}
    </div>

module.exports = CategoryThumbnailList.toComponent()
