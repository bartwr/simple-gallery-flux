class ImageThumbnailListItem extends Component
  
  _onClick: (e) ->
    e.preventDefault()
    @props.onClick @props.image
  
  render: ->
    <div className="block col1 thumbnail" onClick={@_onClick}
      style={{backgroundImage: "url('#{@props.image.thumbnail}')"}}>
      <div className="title-overlay"></div>
    </div>

module.exports = ImageThumbnailListItem.toComponent()
