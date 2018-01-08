import React, { Component } from 'react';
import Radium, {StyleRoot} from 'radium';

class CategoryThumbnailListItem extends Component
  
  constructor: (props) ->
    super(props);

  _onClick: (e) ->
    e.preventDefault()
    @props.onClick @props.category
  
  render: ->
    <StyleRoot className="block col1 thumbnail" onClick={@_onClick.bind(@)}
      style={Object.assign({}, backgroundImage: "url('#{@props.image.thumbnail}')", s.base)}>
      <div className="title-overlay">{@props.category.title}</div>
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

export default Radium(CategoryThumbnailListItem)
