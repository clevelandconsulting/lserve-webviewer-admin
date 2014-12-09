angular.module('app').controller 'usersCtrl', ['$scope', '$routeParams', '$location', '$http', 'licensing', '$modal',
 class usersCtrl
  constructor: (@scope, @routeParams, @location, @http, @licensing, @modal)->
   success = (data) => @updateUsers(data)
   error = (error) => @error('Could not retrieve users. ' + error.data.error.message)
   @scope.newuser = {}
   @scope.modal = {
		  open: (size, item, msg, successFn, errorFn) =>
		   #console.log 'item', item, 'msg', msg
		   modalInstance = @modal.open({
	      templateUrl: 'modalDelete.html',
	      controller: 'modalDeleteCtrl',
	      size: size,
	      backdrop: true,
	      resolve: {
		       item: () -> item,
		       msg: () -> msg
	      }
	    });
	    modalInstance.result.then(successFn, errorFn)
   }
   
   @http.get(@licensing.url + 'user').then success, error
  
  closeAlert: () ->
	  @scope.message = undefined
  
  error: (msg) ->
   @scope.message = { msg: msg, level: 'danger' }
  
  updateUsers: (data) -> 
   @users = data.data
  
  newuser: (newuser) ->
   newuser.ready = @hasRequiredProperties(newuser.properties)
  
  hasRequiredProperties: (properties) ->
   if properties?
		  if properties.email? && properties.email != ''
		   if properties.password? && properties.password != ''
		    return true
   false
  
  changed: (u) ->
   u.changed = true 
   
  
  add: (newuser) ->
   success = (data) =>
    @scope.message = {msg:'Added!',level:'success'}
    @users.push(data.data)
    @scope.newuser = {}
    
   error = (error) => @error('Could not add. ' + error.data.error.message)
    
   @http.post(@licensing.url + 'user', newuser.properties).then success, error
   
  remove: (u, i) ->
   success = (data) =>
    @scope.message = {msg:'Removed!',level:'success'}
    @users.splice(i,1)
    
   error = (error) => @error('Could not remove. ' + error.data.error.message)
   
   @scope.modal.open 'sm','User','This will remove the user. This can not be undone.  Do you want to continue?', ()=>
		  @http.delete(@licensing.url + 'user/' + u.key).then success, error

  update: (u) ->
   success = (data) =>
    u.changed = false;
    @scope.message = {msg:'Updated!',level:'success'}
    
   error = (error) => @error('Could not update. ' + error.data.error.message)
    
   @http.put(@licensing.url + 'user/' + u.key, u.properties).then success, error
   
]