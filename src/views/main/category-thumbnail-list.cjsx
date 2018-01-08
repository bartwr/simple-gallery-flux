import React, {Component} from 'react'
import Radium, {StyleRoot} from 'radium';

import CategoryThumbnailListItem from './category-thumbnail-list-item'

class CategoryThumbnailList extends Component
  
  render: ->
    
    # Collect category thumbnails.
    items = []
    for id, item of @props.categories
      
      # Use the first image as category thumbnail.
      image = if item.images then @props.images[ item.images[0] ] else ''
 
      items.push <CategoryThumbnailListItem key={id} category={item} image={image} onClick={@props.onClick.bind(@)} />
    
    <div className="category-thumbnail-list" style={s.categoryThumbnailList}>
      <StyleRoot className="block col1 title" style={s.titleBlock}>Albums</StyleRoot>
      {items}
    </div>

s =
  categoryThumbnailList:
    display: 'flex'
    flex: 1
    justifyContent: 'flex-start'
    flexWrap: 'wrap'
  titleBlock:
    display: 'block'
    '@media(max-width: 800px)':
      display: 'none'

export default Radium(CategoryThumbnailList)
