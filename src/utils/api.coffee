prefix = '/rest/simple_gallery/'

Ajax = (method, resource, data) ->
  jQuery.ajax
    type: method
    dataType: 'json'
    data: if data? then JSON.stringify(data)
    url: prefix+resource
    contentType: 'application/json'

module.exports = 
  
  getGallery: (id) ->
    Ajax 'GET', "gallery/#{id}"
  
