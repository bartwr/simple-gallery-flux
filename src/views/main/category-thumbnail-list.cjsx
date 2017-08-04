CategoryThumbnailListItem = require './category-thumbnail-list-item'

class CategoryThumbnailList extends Component
  
  render: ->
    
    # Collect category thumbnails.
    items = []
    for id, item of @props.categories
      
      # Use the first image as category thumbnail.
      image = if item.images then @props.images[ item.images[0] ] else ''
 
      items.push <CategoryThumbnailListItem key={id} category={item} image={image} onClick={@props.onClick} />
    
    <div className="category-thumbnail-list" style={s.categoryThumbnailList}>
      <div className="block col1 title" style={s.titleBlock}>Albums</div>
      {items}
    </div>

s =
  categoryThumbnailList:
    display: 'flex'
    justifyContent: 'flex-start'
    flexWrap: 'wrap'
    marginLeft: '220px'
  titleBlock:
    display: 'block'

module.exports = CategoryThumbnailList.toComponent()
