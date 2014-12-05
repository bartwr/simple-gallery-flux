CategoryListItem = require './category-list-item'
Location = require 'src/utils/location'

class CategoryList extends Component
  
  _onClickAlbums: (e) ->
    e.preventDefault()
    @props.onOpenAlbums()
  
  render: ->
    return <div></div> unless @props.activeCategory
    
    items = []
    for cid, category of @props.categories
      items.push <CategoryListItem key={cid} isActive={@props.activeCategory == category}
        category={category} onClick={@props.onOpenCategory} />
    
    <div className="subnav block col1">
      <a href={Location.getPath()} onClick={@_onClickAlbums}><strong>Albums</strong></a>
      <ul>{items}</ul>
    </div>

module.exports = CategoryList.toComponent()
