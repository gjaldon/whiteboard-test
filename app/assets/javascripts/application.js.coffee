#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require fabric
#= require_tree .

$ ->
  pusher = new Pusher 'e34b81788c6d8ccd7086',
    authEndpoint: '/whiteboard/auth'
  channel = pusher.subscribe 'presence-whiteboard'

  canvas = new fabric.Canvas 'whiteboard',
    isDrawingMode: true

  channel.bind 'client-drawing-stopped', (data) ->
    jsonCanvas = JSON.stringify(canvas)
    jsonCanvas = JSON.parse(jsonCanvas)
    jsonCanvas.objects.push(JSON.parse(data.path))
    jsonCanvas = JSON.stringify(jsonCanvas)
    canvas.loadFromJSON(jsonCanvas)

  canvas.on 'path:created', ->
    path = JSON.stringify(canvas._objects.slice(-1)[0])
    channel.trigger 'client-drawing-stopped',
      path: path
