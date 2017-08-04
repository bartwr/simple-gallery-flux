#React = require 'react';
#Swiper = require 'react-swiper'
Location = require 'src/utils/location'

#React.initializeTouchEvents(true)

class ImageFullView extends Component
  
  _onSwipeLeft: (e) ->
    $('#simple-gallery-controller .thumbnail.button').trigger('click')

  _onSwipeRight: (e) ->
    $('#right-button-controller .thumbnail.button').trigger('click')

  render: ->

    embed_url = @props.image.embed_url + '?portrait=0&amp;title=0&amp;color=F58E33&amp;badge=0&amp;byline=0'

    twitter_url = 'https://twitter.com/intent/tweet?text=Take a look in the Outdoor Medicine gallery&url=https://www.outdoormedicine.org' + Location.getPath @props.category, @props.image
    facebook_url = 'http://www.facebook.com/sharer.php?t=Check this image in the Outdoor Medicine gallery&u=https://www.outdoormedicine.org' + Location.getPath @props.category, @props.image

    if @props.image.is_video == true
      media_html = <iframe style={'border': 'none'} src={embed_url}  className="block col3 fullscreen-image" width="100%" height="480" border="0" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
    else
      media_html = <img src={@props.image.full} className="block col3 fullscreen-image" />

    <div onClick={@_onSwipeRight} className="simple-gallery-image-full-view col3 float-left">

      {media_html}

      <div className="block col1 title">
        Share on &raquo;
      </div>
      
      <a className="block twitter title col1" href={twitter_url} title="Share this page on Twitter" target="_blank"></a>
      <a className="block facebook col1" href={facebook_url} target="_blank" title="Share this page on Facebook"></a>
    
    </div>

module.exports = ImageFullView.toComponent()
