class LeftButton extends Component
  
  getNextImage: ->
    currentIndex = @props.activeCategory.images.indexOf(parseInt(@props.activeImage.id, 10))
    nextIndex = if currentIndex <= 0 then @props.activeCategory.images.length-1 else currentIndex-1
    nextImage = @props.images[@props.activeCategory.images[nextIndex]]
  
  _onClick: (e) ->
    e.preventDefault()
    @props.onClick @getNextImage()
  
  render: ->
    return <div></div> unless @props.activeCategory and @props.activeImage
    
    nextImage = @getNextImage()
    <div className="block col1 thumbnail button" onClick={@_onClick}
      style={{backgroundImage: "url('#{nextImage.thumbnail}')"}}>
      <div className="title-overlay">&lt;</div>
    </div>

module.exports = LeftButton.toComponent()
