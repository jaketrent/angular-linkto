(function(){angular.module("angular-linkto",[]),angular.module("angular-linkto").service("keymaster",function(){return{replaceKey:function(a,b,c){return a.replace(":"+b,null!=c?c[b]:void 0)},findKeys:function(a){return a.match(/:[\w\d_\-]+/g)},replaceKeys:function(a,b){var c,d;(null!=b?"function"==typeof b.hasAttributes?b.hasAttributes():void 0:void 0)&&(b=b.toJSON()),d=this.findKeys(a);for(c in b)a=this.replaceKey(a,c,b);return a}}}),angular.module("angular-linkto").filter("linkTo",["keymaster",function(a){var b;return b=function(a){return a.match(/:.*\//)},function(c,d){if(null==c)throw new Error("Route required for linkTo()");if(c=a.replaceKeys(c,d),-1!==c.indexOf(":")){if(b(c))throw new Error("Must provide all data for named params in linkTo(), missing: "+a.findKeys(c)+", in route: "+c);c=c.substring(0,c.lastIndexOf("/"))}return c}}])}).call(this);