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
    var isParamMidString;
    isParamMidString = function(str) {
      return str.match(/:.*\//);
    };
    return function(route, params) {
      if (route == null) {
        throw new Error('Route required for linkTo()');
      }
      route = keymaster.replaceKeys(route, params);
      if (route.indexOf(':') !== -1) {
        if (isParamMidString(route)) {
          throw new Error("Must provide all data for named params in linkTo(), missing: " + (keymaster.findKeys(route)) + ", in route: " + route);
        } else {
          route = route.substring(0, route.lastIndexOf('/'));
        }
      }
      return route;
    };
  });

}).call(this);

/*
//@ sourceMappingURL=angular-linkto.js.map
*/