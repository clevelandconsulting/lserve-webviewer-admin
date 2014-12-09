/* Exports a function which returns an object that overrides the default &
 *   plugin file patterns (used widely through the app configuration)
 *
 * To see the default definitions for Lineman's file paths and globs, see:
 *
 *   - https://github.com/linemanjs/lineman/blob/master/config/files.coffee
 */
module.exports = function(lineman) {
  //Override file patterns here
  return {

    // As an example, to override the file patterns for
    // the order in which to load third party JS libs:
    //
    // js: {
    //   vendor: [
    //     "vendor/js/underscore.js",
    //     "vendor/js/**/*.js"
    //   ]
    // }
    
    webfonts: {
      root: "fonts"
    },
    
    coffee: {
	    app: [
    	 	"app/js/main.coffee",
    	 	"app/js/config.cofee",
    	 	//"app/js/services/**/*.coffee",
    	 	//"app/js/factories/**/*.coffee",
    	 	//"app/js/controllers/**/*.coffee",
    	 	"app/js/**/*.coffee"
    	]
    },

    js: {
    	vendor: [
    	    //"vendor/bower/js-base64/base64.js",
    	    //"vendor/bower/jquery/dist/jquery.js",
    	    //"vendor/bower/jquery-ui/ui/jquery.ui.core.js",
    	    //"vendor/bower/jquery-ui/ui/jquery.ui.widget.js",
    	    //"vendor/bower/jquery-ui/ui/jquery.ui.mouse.js",
    	    //"vendor/bower/jquery-ui/ui/jquery.ui.sortable.js",
    	    //"vendor/bower/toastr/toastr.js",
    	    //"vendor/bower/underscore/underscore.js",
    	    //"vendor/bower/underscore.string/lib/underscore.string.js",
    	    //"vendor/bower/foundation/js/foundation.js",
    	    //"vendor/bower/amplify/lib/amplify.js",
    	    //"vendor/bower/amplify/lib/amplify.store.js",
         "vendor/bower/angular/angular.js",
         "vendor/bower/angular-resource/angular-resource.js",
         "vendor/bower/angular-route/angular-route.js",
         "vendor/bower/angular-sanitize/angular-sanitize.js",
         "vendor/bower/autofill-event/src/autofill-event.js",
         "vendor/bower/angular-bootstrap/ui-bootstrap.js",
         "vendor/bower/angular-bootstrap/ui-bootstrap-tpls.js",
         //"vendor/bower/firebase/firebase.js",
         //"vendor/bower/angularfire/dist/angularfire.js",
         //"vendor/bower/angular-local-storage/dist/angular-local-storage.js",
         //"vendor/bower/angular-ui-sortable/sortable.js",
         "vendor/js/**/*.js"  //Note that this glob remains for traditional vendor libs
     ],
     specHelpers: [
		       "vendor/bower/angular-mocks/angular-mocks.js",
         "spec/helpers/**/*.js"
     ],
     minified: "dist/js/admin.app.js"
    },
    
    //css: {
    //  vendor: [
    //     "vendor/bower/toastr/toastr.css"
    //  ]
    // }
    
  };
};
