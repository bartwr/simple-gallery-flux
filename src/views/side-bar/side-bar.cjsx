import React, {Component} from 'react'

import CategoryList from './category-list'
import LeftButton from './left-button'

class SideBar extends Component

  constructor: (props) ->
    super(props);

  render: ->

    <div className="left">
      <LeftButton onClick={@props.onLeftButtonClick}
        activeCategory={@props.activeCategory}
        images={@props.images} activeImage={@props.activeImage} />
      <CategoryList onOpenCategory={@props.onOpenCategory.bind(@)} onOpenAlbums={@props.onOpenAlbums.bind(@)}
        categories={@props.categories} activeCategory={@props.activeCategory} />
    </div>

export default SideBar
