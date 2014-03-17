Indie88.StatsRoute = Ember.Route.extend
  model: ->
    Indie88.ajaxPromise '/api/stats'
