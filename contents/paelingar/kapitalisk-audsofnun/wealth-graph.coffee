setup_wealth = ->
    div = d3.select("div.wealth_controls")
    
    div.append("div")
        .attr("class", "wealth_Nlab")
        .append("label")
        .attr("for", "wealth_N")
        .text "Fjöldi"
        
    d3.select(".wealth_Nlab")
        .append("input")
        .attr("id", "wealth_N")
        .attr("type", "number")
        .attr("name", "wealth_N")
        .attr("min", "2")
        .attr("max", "40")
        .attr("step", "2")
        .attr("value", "10")
        .attr "placeholder", "Fjöldi"
  
    div.append("div")
        .attr("class", "wealth_Wlab")
        .append("label")
        .attr("for", "wealth_W")
        .text "Upphafsfé"
        
    d3.select(".wealth_Wlab")
        .append("input")
        .attr("id", "wealth_W")
        .attr("type", "number")
        .attr("name", "wealth_W")
        .attr("min", "20")
        .attr("max", "1000000")
        .attr("step", "20")
        .attr("value", "100")
        .attr "placeholder", "Upphafsfé"
        
    d3.select(".wealth_Wlab")
        .append("button")
        .attr("class", "wealth_reset")
        .attr("title", "Reset")
        .text "⬑"
  
    div.append("div")
        .attr("class", "prev-next-container")

    d3.select(".prev-next-container")
        .append("button")
        .attr("class", "wealth_prev")
        .attr("title", "Previous round")
        .text("<<")

    d3.select(".prev-next-container")
        .append("button")
        .attr("class", "wealth_next")
        .attr("title", "Next round")
        .text ">>"

    return

display_wealth = ->
    N = parseInt(document.getElementById("wealth_N").value)
    W = parseInt(document.getElementById("wealth_W").value)
    yard = Wealth(N, W)
    time = 0
    col_height = (if N > 80 then 2 else 180 / N)
    chart = d3.select("div.wealth_display-results")
        .append("svg")
        .attr("class", "bar-chart")
        .attr("width", "100%")
        .attr("height", col_height * N + 40)
        .append("g")
        .attr("transform", "translate(10,15)")

    x = d3.scale.linear()
        .domain([0, W * 4])
        .range(["0", "80%"])
  
    # COSMETICS {
    chart.selectAll("line")
        .data(x.ticks(12))
        .enter()
        .append("line")
        .attr("x1", x)
        .attr("x2", x)
        .attr("y1", 0)
        .attr("y2", col_height * N)
        .style "stroke", "#ccc"
  
    chart.selectAll(".rule")
        .data(x.ticks(12))
        .enter()
        .append("text")
        .attr("class", "rule")
        .attr("x", x)
        .attr("y", 0)
        .attr("dy", -3)
        .attr("text-anchor", "middle")
        .text String
  
    chart.append("g")
        .attr("class", "round")
        .append("text")
        .attr("y", col_height * (N + 1))
        .attr("x", "80%")
        .attr("dx", "-3em")
        .text "Umferð " + time
    # }

    chart.selectAll("rect")
        .data(yard.data[time])
        .enter()
        .append("rect")
        .attr("y", (d, i) ->
            i * col_height
        )
        .attr("width", (d) ->
            x d.wealth
        )
        .attr "height", col_height
        
    update = ->
        chart.selectAll("rect")
            .data(yard.data[time])
            .transition()
            .duration(750)
            .attr "width", (d) ->
                x d.wealth

        chart.select(".round text").text "Umferð " + time
    
        return

    update_chart = ->
        d3.select(".bar-chart").remove()
        display_wealth()
        return

    d3.select(".wealth_next").on "click", ->
        time += 1
        yard.trade()  if yard.data.length is time
        update()
        return

    d3.select(".wealth_prev").on "click", ->
        if time > 0
          time -= 1
          update()
        return

    d3.select(".wealth_reset").on "click", ->
        N = parseInt(document.getElementById("wealth_N").value)
        W = parseInt(document.getElementById("wealth_W").value)
        yard = Wealth(N, W)
        time = 0
        update_chart()
        update()
        return

    return

setup_wealth()
display_wealth()
