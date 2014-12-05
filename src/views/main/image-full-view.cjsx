class ImageFullView extends Component
  
  render: ->
    <img src={@props.image.full} className="block col3 fullscreen-image" />

module.exports = ImageFullView.toComponent()
