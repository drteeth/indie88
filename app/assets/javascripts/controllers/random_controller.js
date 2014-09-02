Indie88.RandomController = Ember.ObjectController.extend({

  actions: {
    femIt: function(level) {
      this.set('femLevel', level);
      this.get('model').save();
    }
  },

  image: function() {
    return "/assets/fem-level-" + this.get('femLevel') + ".jpg"
  }.property('femLevel'),

  femLevelSeleted: function() {

  },

  google: function() {
    return "https://www.google.ca/search?q=" + this.get('name');
  }.property('name')

})
