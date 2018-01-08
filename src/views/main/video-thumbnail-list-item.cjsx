class VideoThumbnailListItem extends Component
  
  _onClick: (e) ->
    e.preventDefault()
    @props.onClick @props.image
  
  render: ->
    <div className="block col1 thumbnail is-video" onClick={@_onClick}
      style={{backgroundImage: "url('#{@props.image.thumbnail}')"}}>
      <div className="title-overlay"></div>
      <div className="play-triangle"></div>
    </div>

export default VideoThumbnailListItem
