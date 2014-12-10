class LeftButton extends Component
  
  componentDidMount: ->
    jQuery(document).bind 'keyup', this, @_onKeyPress
    
  componentWillUnmount: ->
    jQuery(document).unbind 'keyup', @_onKeyPress
  
  getNextImage: ->
    currentIndex = @props.activeCategory.images.indexOf(parseInt(@props.activeImage.id, 10))
    nextIndex = if currentIndex <= 0 then @props.activeCategory.images.length-1 else currentIndex-1
    nextImage = @props.images[@props.activeCategory.images[nextIndex]]
  
  _onKeyPress: (e) ->
    if e.keyCode == 37
      e.data._onNext(e)
  
  _onNext: (e) ->
    return unless @props.activeCategory and @props.activeImage
    e.preventDefault()
    @props.onClick @getNextImage()
  
  render: ->
    return <div></div> unless @props.activeCategory and @props.activeImage
    
    nextImage = @getNextImage()
    <div className="block col1 thumbnail button" onClick={@_onNext}
      style={{backgroundImage: "url('#{nextImage.thumbnail}')"}}>
      <div className="title-overlay"><i className="fa fa-chevron-left"></i></div>
    </div>

module.exports = LeftButton.toComponent()
