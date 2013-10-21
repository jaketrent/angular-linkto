(function() {
  angular.module('angular-linkto', []);

  angular.module('angular-linkto').service('keymaster', function() {
    return {
      replaceKey: function(str, key, params) {
        return str.replace(":" + key, params != null ? params[key] : void 0);
      },
      findKeys: function(str) {
        return str.match(/:[\w\d_\-]+/g);
      },
      replaceKeys: function(str, params) {
        var key, keys;
        if (params != null ? typeof params.hasAttributes === "function" ? params.hasAttributes() : void 0 : void 0) {
          params = params.toJSON();
        }
        keys = this.findKeys(str);
        for (key in params) {
          str = this.replaceKey(str, key, params);
        }
        return str;
      }
    };
  });

  angular.module('angular-linkto').filter('linkTo', function(keymaster) {
    var containsColon, containsColonAfterProtocol, containsColonBeforeSlash, containsProtocol, dropLastParam, throwUnfilledParamError;
    containsColon = function(str) {
      return str.indexOf(':') > -1;
    };
    containsColonAfterProtocol = function(str) {
      return str.match(/^\w+:\/\/.*:/);
    };
    containsColonBeforeSlash = function(str) {
      return str.match(/:[\w\d_\-]+\//);
    };
    containsProtocol = function(str) {
      return str.match(/^\w+:\/\/.*/);
    };
    dropLastParam = function(str) {
      return str.substring(0, str.lastIndexOf('/'));
    };
    throwUnfilledParamError = function(str) {
      throw new Error("Must provide all data for named params in linkTo(), missing: " + (keymaster.findKeys(str)) + ", in route: " + str);
    };
    return function(route, params) {
      if (route == null) {
        throw new Error('Route required for linkTo()');
      }
      route = keymaster.replaceKeys(route, params);
      if (containsProtocol(route)) {
        if (containsColonAfterProtocol(route)) {
          if (containsColonBeforeSlash(route)) {
            throwUnfilledParamError(route);
          } else {
            route = dropLastParam(route);
          }
        }
      } else if (containsColon(route)) {
        if (containsColonBeforeSlash(route)) {
          throwUnfilledParamError(route);
        } else {
          route = dropLastParam(route);
        }
      }
      return route;
    };
  });

}).call(this);

/*
//@ sourceMappingURL=angular-linkto.js.map
*/