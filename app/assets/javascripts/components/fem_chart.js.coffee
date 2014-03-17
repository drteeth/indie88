Indie88.FemChartComponent = Ember.Component.extend
  classNames: ['chart']

  didInsertElement: ->
    Ember.run.once this, 'update'

  update: ->
    data = this.get('data')

    w = 300
    h = 300
    r = 100

    color = d3.scale.category20c()

    vis = d3.select(this.$()[0])
      .append("svg:svg")
      .data([data.artists])
      .attr("width", w)
      .attr("height", h)
      .append("svg:g")
      .attr("transform", "translate(" + r + "," + r + ")")

    arc = d3.svg.arc()
      .outerRadius(r)

    pie = d3.layout.pie()
      .value((d) -> d.value )

    arcs = vis.selectAll("g.slice")
      .data(pie)
      .enter()
      .append("svg:g")
      .attr("class", "slice")

    arcs.append("svg:path")
      .attr "fill", (d, i) ->
        color(i)
      .attr "d", arc

    arcs.append("svg:text")
      .attr "transform", (d) ->
        d.innerRadius = 0
        d.outerRadius = r
        "translate(" + arc.centroid(d) + ")"
      .attr("text-anchor", "middle")
      .text((d, i) -> data.artists[i].label )



