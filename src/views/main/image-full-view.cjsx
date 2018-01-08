import React, {Component} from 'react';
import Radium, {StyleRoot} from 'radium';

import Location from '../../utils/location'

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
      media_html = <iframe style={'border': 'none'} src={embed_url} className="fullscreen-image" width="100%" height="480" style={s.imageFull} border="0" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
    else
      media_html = <img src={@props.image.full} className="fullscreen-image" style={s.imageFull} />

    <StyleRoot onClick={@_onSwipeRight} className="simple-gallery-image-full-view" style={s.base}>
      {media_html}
    </StyleRoot>

s = {
  base: {
    flex: 1
    '@media(max-width: 800px)': {
      flex: '1 1 100%'
    }
  }
  imageFull: {
    margin: '15px 0'
    width: '100%'
    maxWidth: '100%'
  }
}

export default Radium(ImageFullView)
