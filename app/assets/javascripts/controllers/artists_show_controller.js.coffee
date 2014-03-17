Indie88.ArtistsShowController = Ember.ObjectController.extend
  needs: ['artists']

  femLevels: [
    {level:0, title:'None'}
    {level:1, title:'Backing Member'}
    {level:2, title:'Female Fronted'}
    {level:3, title:'Shared'}
    {level:4, title:'All Female'}
  ]

  artists: Ember.computed.alias 'controllers.artists'

  next: (->
    artists = @get('artists')
    current = artists.indexOf @get('model')
    len = artists.get('length')
    next = (current + 1) % len
    artists.objectAt(next)
  ).property('artists', 'model')

  prev: (->
    artists = @get('artists')
    current = artists.indexOf @get('model')
    len = artists.get('length')
    prev = (current - 1) % len
    artists.objectAt(prev)
  ).property('artists', 'model')

  google: (->
    "https://www.google.ca/search?q=" + @get('name')
  ).property('name')

  actions:
    save: ->
      @get('model').save();
