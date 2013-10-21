angular.module 'angular-linkto', []
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

angular.module('angular-linkto').filter 'linkTo', (keymaster) ->

  containsColon = (str) ->
    str.indexOf(':') > -1

  containsColonAfterProtocol = (str) ->
    str.match /^\w+:\/\/.*:/

  containsColonBeforeSlash = (str) ->
    str.match /:[\w\d_\-]+\//

  containsProtocol = (str) ->
    str.match /^\w+:\/\/.*/

  dropLastParam = (str) ->
    str.substring(0, str.lastIndexOf('/'))

  throwUnfilledParamError = (str) ->
    throw new Error "Must provide all data for named params in linkTo(), missing: #{keymaster.findKeys(str)}, in route: #{str}"

  (route, params) ->
    unless route?
      throw new Error 'Route required for linkTo()'

    route = keymaster.replaceKeys route, params

    if containsProtocol route
      if containsColonAfterProtocol route
        if containsColonBeforeSlash route
          throwUnfilledParamError route
        else
          route = dropLastParam route
    else if containsColon route
      if containsColonBeforeSlash route
        throwUnfilledParamError route
      else
        route = dropLastParam route
    route
