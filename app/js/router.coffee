angular.module('app').config ['$routeProvider', (routeProvider) ->
 #locationProvider.html5mode(true)
 
 routeProvider
 .when('/',{controller: 'homeCtrl', controllerAs:'home', templateUrl: 'home.html'})
 .when('/users', {controller: 'usersCtrl', controllerAs:'users', templateUrl: 'users.html'})
 .when('/accounts/:id', {controller: 'accountCtrl', controllerAs:'account', templateUrl: 'account.html'})
 .when('/accounts', {controller: 'accountsCtrl', controllerAs:'accounts', templateUrl: 'accounts.html'})
 .otherwise {redirectTo:'/'}
 
]
