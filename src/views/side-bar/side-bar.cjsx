import CategoryList from './category-list'
import LeftButton from './left-button'

class SideBar extends Component
  
  render: ->
    <div className="left">
      <LeftButton onClick={@props.onLeftButtonClick}
        activeCategory={@props.activeCategory}
        images={@props.images} activeImage={@props.activeImage} />
      <CategoryList onOpenCategory={@props.onOpenCategory} onOpenAlbums={@props.onOpenAlbums}
        categories={@props.categories} activeCategory={@props.activeCategory} />
    </div>

export default SideBar
