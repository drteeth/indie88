Indie88.ArtistsShowController = Ember.ObjectController.extend

  femLevels: [
    {level:0, title:'None'}
    {level:1, title:'Backing Member'}
    {level:2, title:'Female Fronted'}
    {level:3, title:'All Female'}
  ]

  actions:
    save: ->
      @get('model').save();
