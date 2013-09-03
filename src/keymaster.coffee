angular.module('angular-linkto').service 'keymaster', ->

  replaceKey: (str, key, params) ->
    str.replace ":#{key}", params?[key]

  findKeys: (str) ->
    str.match /:[\w\d_\-]+/g

  replaceKeys: (str, params) ->
    params = params.toJSON() if params?.hasAttributes?()
    keys = @findKeys str
    str = @replaceKey(str, key, params) for key of params
    str
