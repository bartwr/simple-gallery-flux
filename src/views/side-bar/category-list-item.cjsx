import React, { Component } from 'react';
import Location from '../../utils/location'

class CategoryListItem extends Component
  
  _onClick: (e) ->
    e.preventDefault()
    @props.onClick @props.category
  
  render: ->
    <li className={if @props.isActive then 'active'}>
      <a href={Location.getPath @props.category} onClick={@_onClick}>{@props.category.title}</a>
    </li>

export default CategoryListItem
