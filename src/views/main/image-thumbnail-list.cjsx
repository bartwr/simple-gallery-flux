import React, {Component} from 'react'
import Radium, {StyleRoot} from 'radium';

import VideoThumbnailListItem from './video-thumbnail-list-item'
import ImageThumbnailListItem from './image-thumbnail-list-item'

class ImageThumbnailList extends Component
  
  render: ->
    
    @props = @props

    # Images of this category only.
    items = []

    if @props.category.images
      for id in @props.category.images
        image = @props.images[id]
        items.push <ImageThumbnailListItem key={id} image={image} onClick={@props.onClick.bind(@)} />
    
    <div className="image-thumbnail-list" style={s.imageThumbnailList}>
      <StyleRoot className="block col1 title" style={s.title}>{@props.category.title}</StyleRoot>
      {items}
    </div>

s =
  imageThumbnailList:
    display: 'flex'
    flex: 1
    justifyContent: 'flex-start'
    flexWrap: 'wrap'
  title:
   '@media (max-width: 800px)': {
      width: '100%'
    }

export default Radium(ImageThumbnailList)
