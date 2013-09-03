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
