import React, {Component} from 'react'

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
      <div className="block col1 title">{@props.category.title}</div>
    </div>

s =
  imageThumbnailList:
    display: 'flex'
    justifyContent: 'flex-start'
    flexWrap: 'wrap'
    marginLeft: '220px'

export default ImageThumbnailList
