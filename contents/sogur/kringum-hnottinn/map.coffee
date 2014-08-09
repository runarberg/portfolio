L.mapbox.accessToken = 'pk.eyJ1IjoicnVuYXJiZXJnIiwiYSI6IjhqWmd0ZTgifQ.tq-NpBG7oDG9Q7Vc9pIsJw'

map = L.mapbox.map 'toc-map', 'runarberg.j54p5f5j', zoomControl: false
map.scrollWheelZoom.disable()

map.setView [63.9, -22.46], 5

tocLayer = L.mapbox.featureLayer()
        .loadURL('toc.geojson')
        .on 'layeradd', (e) ->
            marker = e.layer
            feature = marker.feature
            if feature.id.match /point$/
                marker.setIcon L.divIcon
                    className:"toc-spot "+ feature.id
                    iconSize: [50, 50]
                    html: "<a href='#{feature.properties.href}'>#{feature.properties.h1}</a>"
            return
        .on 'click', (e) ->
            window.location.hash = e.layer.feature.properties.href
            return
        .addTo map

stateInputs = document.querySelectorAll "input[name='toc-state']"
Array.prototype.forEach.call stateInputs, (input) ->
    d = input.dataset
    map.setView [d.lat, d.lng], d.zoom  if input.checked
    input.addEventListener "change", (e) ->
        map.setView [d.lat, d.lng], d.zoom

tocAnchors = document.querySelectorAll ".toc a[href^='#']"
Array.prototype.forEach.call tocAnchors, (anchor) ->
    anchor.addEventListener "mouseover", (e) ->
        href = this.hash.substr 1
        point = document.querySelector ".toc-#{href}-point"
        point.classList.add("hover") if point
        return
    anchor.addEventListener "mouseout", (e) ->
        href = this.hash.substr 1
        point = document.querySelector ".toc-#{href}-point"
        point.classList.remove("hover") if point
        return
    return
