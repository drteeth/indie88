Indie88.Song = DS.Model.extend
  songtitle: DS.attr 'string'
  name: Ember.computed.alias 'songtitle'
