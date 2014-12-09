angular.module('app').controller 'modalDeleteCtrl', ['$scope','$modalInstance', 'item', 'msg', 
 class modalDeleteCtrl
  constructor: (@$scope,@$modalInstance,@item,@msg) ->
   #console.log this
   @$scope.item = @item
   @$scope.msg = @msg
   @$scope.delete = () =>
    @$modalInstance.close()
   
   @$scope.cancel = () =>
    @$modalInstance.dismiss()
   
   
   #console.log 'modal scope', @$scope
  
]