Indie88.ArtistsIndexController = Ember.ArrayController.extend({
  needs: ['artists']
  artists: Ember.computed.alias 'controllers.artists'
})
