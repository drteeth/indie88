Indie88.ArtistsRoute = Ember.Route.extend
  model: ->
    @store.find 'artist'
