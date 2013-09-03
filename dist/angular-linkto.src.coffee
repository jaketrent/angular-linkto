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

  isParamMidString = (str) ->
    str.match /:.*\//

  (route, params) ->
    unless route?
      throw new Error 'Route required for linkTo()'

    route = keymaster.replaceKeys route, params
    if route.indexOf(':') != -1
      if isParamMidString route
        throw new Error "Must provide all data for named params in linkTo(), missing: #{keymaster.findKeys(route)}, in route: #{route}"
      else
        route = route.substring(0, route.lastIndexOf('/'))
    route
