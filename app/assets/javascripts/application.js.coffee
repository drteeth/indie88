#= require jquery
#= require handlebars
#= require ember
#= require d3/d3
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

# stolzed from http://stackoverflow.com/questions/21241913/how-to-execute-ember-rsvp-all-within-an-ember-run-loop-correctly
Indie88.ajaxPromise = (url, method='GET', options = {}) ->
  new Ember.RSVP.Promise (resolve, reject) ->
    options.url = url
    options.method = method
    options.dataType = 'json'

    options.success = (json) ->
      Ember.run(null, resolve, json)

    options.error = (json) ->
        json.then = null if json && json.then
        Ember.run(null, reject, json)

    $.ajax(options)
