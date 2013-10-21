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
