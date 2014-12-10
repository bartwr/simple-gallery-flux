class LeftButton extends Component
  
  componentDidMount: ->
    if @props.activeCategory? and @props.activeImage?
      jQuery(document).bind 'keypress', @_onKeyPress
    
  componentWillUpdate: (newProps) ->
    willBeActive = newProps.activeCategory? and newProps.activeImage?
    wasActive = @props.activeCategory? and @props.activeImage?
    
    if willBeActive and not wasActive
      jQuery(document).bind 'keypress', @_onKeyPress
    
    if not willBeActive and wasActive
      jQuery(document).unbind 'keypress', @_onKeyPress
  
  getNextImage: ->
    currentIndex = @props.activeCategory.images.indexOf(parseInt(@props.activeImage.id, 10))
    nextIndex = if currentIndex <= 0 then @props.activeCategory.images.length-1 else currentIndex-1
    nextImage = @props.images[@props.activeCategory.images[nextIndex]]
  
  _onKeyPress: (e) ->
    if e.key == 'Left'
      ((e) => @_onNext(e))(e)
  
  _onNext: (e) ->
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
