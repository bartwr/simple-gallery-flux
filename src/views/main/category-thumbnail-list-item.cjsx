import React, { Component } from 'react';

class CategoryThumbnailListItem extends Component
  
  constructor: (props) ->
    super(props);

  _onClick: (e) ->
    e.preventDefault()
    @props.onClick @props.category
  
  render: ->
    <div className="block col1 thumbnail" onClick={@_onClick.bind(@)}
      style={{backgroundImage: "url('#{@props.image.thumbnail}')", width: '220px', float: 'none', maxWidth: '100%'}}>
      <div className="title-overlay">{@props.category.title}</div>
    </div>

export default CategoryThumbnailListItem
