angular.module('app').controller 'accountCtrl', ['$scope', '$routeParams', '$location', '$http', 'licensing', '$modal',
 class accountCtrl
  constructor: (@scope, @routeParams, @location, @http, @licensing, @modal)->
   #console.log 'accountCtrl', @routeParams
   @accountId = @routeParams.id
   @baseUrl = @licensing.url + 'account/' + @accountId
   
   @scope.newpayment = {} 
   
   accountsuccess = (data) => @updateAccount(data)
   paymentsuccess = (data) => @updatePayments(data)
   error = (error) => @error('Could not retrieve account information. ' + error.data.error.message)
   @http.get(@baseUrl).then accountsuccess, error
   @http.get(@baseUrl+'/payment').then paymentsuccess, error
   
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

  closeAlert: () ->
	  @scope.message = undefined

  error: (msg) ->
   @scope.message = { msg: msg, level: 'danger' }
  
  updateAccount: (data) -> 
   @account = data.data
  
  updatePayments: (data) -> 
   #console.log 'updating payments', data
   if data.data != null
    @payments = data.data
   else
    @payments = []
  
  newpayment: (newpayment) ->
   newpayment.ready = @hasRequiredProperties(newpayment.properties)
  
  hasRequiredProperties: (properties) ->
   if properties?
		  if properties.date? && properties.date != ''
		   if properties.amount? && properties.amount != ''
		    return true
   false
  
  changed: (p) ->
   p.changed = true 
   
  
  addPayment: (newpayment) ->
   success = (data) =>
    @scope.message = {msg:'Added Payment!',level:'success'}
    @payments.push(data.data)
    @scope.newpayment = {}
    
   error = (error) => @error('Could not add. ' + error.data.error.message)
   
   console.log 'posting to', @baseUrl + '/payment', newpayment.properties
   @http.post(@baseUrl + '/payment', newpayment.properties).then success, error
   
   
  updatePayment: (p) ->
   success = (data) =>
    @scope.message = {msg:'Updated Payment!',level:'success'}
    p.changed = false
    
   error = (error) => @error('Could not update. ' + error.data.error.message)
    
   @http.put(@licensing.url + 'payment/' + p.key, p.properties).then success, error
   
  removePayment: (p, i) ->
   success = (data) =>
    @scope.message = {msg:'Removed Payment!',level:'success'}
    @payments.splice(i,1)
    
   error = (error) => @error('Could not remove payment. ' + error.data.error.message)
   @scope.modal.open 'sm','Payment','This will remove the payment. This can not be undone.  Do you want to continue?', ()=>
    @http.delete(@licensing.url + 'payment/' + p.key).then success, error
    
  remove: () ->
   success = (data) =>
    @scope.message = {msg:'Removed!',level:'success'}
    @location.path('accounts')
    
   error = (error) => @error('Could not remove. ' + error.data.error.message)
   @scope.modal.open 'sm','Account','This will remove the account. This can not be undone.  Do you want to continue?', ()=>
    @http.delete(@baseUrl).then success, error
    
  update: (p) ->
   success = (data) =>
    p.changed = false;
    @scope.message = {msg:'Updated Account!',level:'success'}
    
   error = (error) => @error('Could not update. ' + error.data.error.message)
    
   @http.put(@baseUrl, p.properties).then success, error
   
]