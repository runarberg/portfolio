window.Wealth = (N, W) ->
        
    # initialize all with wealth W at time 0
    data = [{time: 0, indv: i, wealth: W} for i in [1..N]]
    
    trade = ->
        old_data = data[data.length - 1]
        new_data = []
      
        # First shuffle in pairs
        pairs = d3.shuffle(d3.range(N))

        # and have them trade in the shuffled order
        i = 0
        while i < N
            a = pairs[i]
            b = pairs[i + 1]
            stake = Math.min(old_data[a].wealth, old_data[b].wealth)
            pot = 2*stake
            result = d3.random.normal(0.5, 0.1)()
            
            # assign the trade results.
            new_data[a] =
                time: old_data[a].time + 1
                indv: a
                wealth: (old_data[a].wealth + result * pot - stake)
            new_data[b] =
                time: old_data[b].time + 1
                indv: b
                wealth: (old_data[b].wealth + (1 - result) * pot - stake)
            i += 2
        data[data.length] = new_data
        return new_data
       
    return {
        trade: trade
        data: data
    }
