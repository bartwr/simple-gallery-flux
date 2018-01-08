import React, {Component} from 'react'
import Radium, {StyleRoot} from 'radium';

class ImageThumbnailListItem extends Component
  
  _onClick: (e) ->
    e.preventDefault()
    @props.onClick @props.image
  
  render: ->

    if @props.image.is_video == true
      triangle = <div className="play-triangle"></div>

    <StyleRoot className="block col1 thumbnail" onClick={@_onClick.bind(@)}
      style={Object.assign({}, backgroundImage: "url('#{@props.image.thumbnail}')", s.base)}>
      <div className="title-overlay"></div>
      {triangle}
    </StyleRoot>

s = {
  base: {
    width: '220px'
    float: 'none'
    maxWidth: '100%'
    '@media(max-width: 800px)': {
      width: '100%'
    }
  }
}

export default Radium(ImageThumbnailListItem)
