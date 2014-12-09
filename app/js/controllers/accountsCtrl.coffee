angular.module('app').controller 'accountsCtrl', ['$scope', '$routeParams', '$location', '$http', 'licensing', '$modal',
 class accountsCtrl
  constructor: (@scope, @routeParams, @location, @http, @licensing, @modal)->
   success = (data) => @updateAccounts(data)
   error = (error) => @error('Could not retrieve accounts. ' + error.data.error.message)
   @scope.newaccount = {}
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
   @http.get(@licensing.url + 'account').then success, error
  
  closeAlert: () ->
	  @scope.message = undefined
  
  error: (msg) ->
   @scope.message = { msg: msg, level: 'danger' }
  
  updateAccounts: (data) -> 
   @accounts = data.data
  
  newaccount: (newaccount) ->
   newaccount.ready = @hasRequiredProperties(newaccount.properties)
  
  hasRequiredProperties: (properties) ->
   if properties?
		  if properties.email? && properties.email != ''
		   if properties.company? && properties.company != ''
		    if properties.userCount? && properties.userCount != ''
		     return true
   false
  
  changed: (p) ->
   p.changed = true 
   
  
  add: (newaccount) ->
   success = (data) =>
    @scope.message = {msg:'Added!',level:'success'}
    @accounts.push(data.data)
    @scope.newaccount = {}
    
   error = (error) => @error('Could not add. ' + error.data.error.message)
    
   @http.post(@licensing.url + 'account', newaccount.properties).then success, error
   
  remove: (p, i) ->
   success = (data) =>
    @scope.message = {msg:'Removed!',level:'success'}
    @accounts.splice(i,1)
    
   error = (error) => @error('Could not remove. ' + error.data.error.message)
   @scope.modal.open 'sm','Account','This will remove the account. This can not be undone.  Do you want to continue?', ()=>
    @http.delete(@licensing.url + 'account/' + p.key).then success, error
  
  update: (p) ->
   success = (data) =>
    p.changed = false;
    @scope.message = {msg:'Updated!',level:'success'}
    
   error = (error) => @error('Could not update. ' + error.data.error.message)
    
   @http.put(@licensing.url + 'account/' + p.key, p.properties).then success, error
   
]