do (Backbone) ->
	_sync = Backbone.sync

	Backbone.sync = (method, entity, options = {}) ->
		
		_.defaults options,
			beforeSend: _.bind(methods.beforeSend, 	entity)
			beforeSend = (xhr) ->
        xhr.setRequestHeader "X-CSRFToken", CSRF_TOKEN
			complete:		_.bind(methods.complete,		entity)
		
		sync = _sync(method, entity, options)
		if !entity._fetch and method is "read"
			entity._fetch = sync
	
	methods =
		beforeSend: ->
			@trigger "sync:start", @
		
		complete: ->
			@trigger "sync:stop", @


# oldSync = Backbone.sync
# Backbone.sync = (method, model, options) ->
#   options.beforeSend = (xhr) ->
#     xhr.setRequestHeader "X-CSRFToken", CSRF_TOKEN
#     return

#   oldSync method, model, options