import React, {Component} from 'react'
import Radium, {StyleRoot} from 'radium';

import CategoryList from './category-list'
import LeftButton from './left-button'

class SideBar extends Component

  constructor: (props) ->
    super(props);

  render: ->

    <StyleRoot style={s.base}>
      <LeftButton onClick={@props.onLeftButtonClick}
        activeCategory={@props.activeCategory}
        images={@props.images} activeImage={@props.activeImage} />
      <CategoryList onOpenCategory={@props.onOpenCategory.bind(@)} onOpenAlbums={@props.onOpenAlbums.bind(@)}
        categories={@props.categories} activeCategory={@props.activeCategory} />
    </StyleRoot>

s = {
  base: {
    width: '250px'
    '@media (max-width: 800px)': {
      display: 'none'
    }
  }
}

export default Radium(SideBar);
