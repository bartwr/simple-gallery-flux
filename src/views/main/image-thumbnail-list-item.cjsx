class ImageThumbnailListItem extends Component
  
  _onClick: (e) ->
    e.preventDefault()
    @props.onClick @props.image
  
  render: ->

    if @props.image.is_video == true
      triangle = <div className="play-triangle"></div>

    <div className="block col1 thumbnail" onClick={@_onClick}
      style={{backgroundImage: "url('#{@props.image.thumbnail}')"}}>
      <div className="title-overlay"></div>
      {triangle}
    </div>

export default ImageThumbnailListItem
