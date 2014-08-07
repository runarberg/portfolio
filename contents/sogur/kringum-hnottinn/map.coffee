L.mapbox.accessToken = 'pk.eyJ1IjoicnVuYXJiZXJnIiwiYSI6IjhqWmd0ZTgifQ.tq-NpBG7oDG9Q7Vc9pIsJw'

map = L.mapbox.map('toc-map', 'runarberg.j54p5f5j')
map.scrollWheelZoom.disable()

map.setView [63.9, -22.46], 5

stateInputs = document.querySelectorAll "input[name='toc-state']"
Array.prototype.forEach.call stateInputs, (input) ->
    d = input.dataset
    map.setView [d.lat, d.lng], d.zoom  if input.checked
    input.addEventListener "change", (e) ->
        map.setView [d.lat, d.lng], d.zoom
