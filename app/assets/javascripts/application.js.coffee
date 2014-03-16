#= require jquery
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require indie88

window.Indie88 = Ember.Application.create
  LOG_ACTIVE_GENERATION: true
  LOG_TRANSITIONS: true
  LOG_VIEW_LOOKUPS: true

$(document).ajaxSend (e, xhr, options) ->
  token = $("meta[name='csrf-token']").attr("content")
  xhr.setRequestHeader "X-CSRF-Token", token
