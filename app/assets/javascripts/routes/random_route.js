Indie88.RandomRoute = Ember.Route.extend({
  actions: {
    notherOne: function() {
      this.refresh();
    }
  },

  model: function() {
    var store = this.store;
    return Indie88.ajaxPromise('/api/artists/random').then(function(response) {
      return store.push('artist', response.artist);
    });
  }
});
