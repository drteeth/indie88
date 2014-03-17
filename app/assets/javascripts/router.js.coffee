Indie88.Router.map ->
  @resource 'artists', {path: '/artists'}, ->
    @route 'index', path: '/'
    @route 'show', path: '/:artist_id'
  @resource 'stats', {path: '/stats'}
