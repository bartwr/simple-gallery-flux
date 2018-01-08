import React, {Component} from 'react'

import CategoryListItem from './category-list-item'
import Location from '../../utils/location'

class CategoryList extends Component

  constructor: (props) ->
    super(props)
  
  _onClickAlbums: (e) ->
    e.preventDefault()
    @props.onOpenAlbums()
  
  render: ->
    return <div></div> unless @props.activeCategory
    
    self = @
    items = []
    for cid, category of @props.categories
      items.push <CategoryListItem key={cid} isActive={@props.activeCategory == category}
        category={category} onClick={self.props.onOpenCategory.bind(@)} />
    
    <div className="subnav block col1">
      <a href={Location.getPath()} onClick={@_onClickAlbums.bind(@)}><strong>Albums</strong></a>
      <ul>{items}</ul>
    </div>

export default CategoryList
