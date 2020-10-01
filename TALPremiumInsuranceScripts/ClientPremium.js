/// <reference path="../scripts/angular.min.js" />
var myPremiumApp = angular.module("ClientPremiumInsurance", []).
    controller("ClientPremiumController", ['$scope', '$log', 'clientPremiumDataService', 'clientPremiumCalculateAgeService', 'clientPremiumCalculationService','clientPremiumCreateService',
        function ($scope, $log, clientPremiumDataService, clientPremiumCalculateAgeService, clientPremiumCalculationService, clientPremiumCreateService) {
            //Declare the scope and properties...
            $scope.clientPremiumList;
            $scope.selectedClientPremium = null;
            $scope.createClientPremium = null;
            $scope.year = 0;
            $scope.validationMessage = null;
            $scope.successMessage = null;
            $scope.InitializeClientPremiums = function () {
                $scope.getClientPremiums();
            }

            $scope.getClientPremiums = function () {
                clientPremiumDataService.GetClientPremiumList(function (data) {
                    $scope.clientPremiumList = data;
                });
            }
            $scope.viewClientPremiumDetails = function (clientPremium) {
                $scope.selectedClientPremium = clientPremium;
            }

            $scope.addClientPremium = function () {
                debugger;
                console.log($scope.createClientPremium);
            }

            $scope.calculateMonthlyPremium = function () {    
                $scope.validationMessage = null;
                if (!$scope.createClientPremium.Name || !$scope.createClientPremium.DeathSumInsured || !$scope.createClientPremium.Age ||
                    !$scope.createClientPremium.OccupationId) {
                    $scope.createClientPremium.OccupationId = 0;
                    $scope.createClientPremium.MonthlyPremium = null;
                    $scope.validationMessage = "Name,Death Insured Sum,Age and Occupation are needed to calculate premium";

                }
                else {
                    var calculatePremiumObject = {
                        DeathSumInsured: $scope.createClientPremium.DeathSumInsured,
                        Age: $scope.createClientPremium.Age,
                        OccupationId: $scope.createClientPremium.OccupationId
                    };
                    var calcObj = JSON.stringify(calculatePremiumObject);
                    clientPremiumCalculationService.GetMonthlyPremiumForClient(calcObj, function (data) {
                        $scope.createClientPremium.MonthlyPremium = data;
                    })
                }               
            }

            $scope.updateAge = function (date) {
                $scope.createClientPremium.MonthlyPremium = null;
                var currentDate = new Date();
                var yearUpperLimit = currentDate.getFullYear() -18;
                var yearLowerLimit = currentDate.getFullYear() - 100;
                var dateYear = date.getFullYear();
                if (dateYear >= yearLowerLimit && dateYear <= yearUpperLimit) {
                    $scope.getClientAge(date);
                    $scope.createClientPremium.OccupationId = 0;
                    $scope.createClientPremium.MonthlyPremium = null;
                }
                else {
                    $scope.createClientPremium.Age = 0;
                    $scope.validationMessage = "Age must be between 18 and 100";
                }

            }

            $scope.getClientAge = function (dob) {
                clientPremiumCalculateAgeService.GetClientAge(dob, function (data) {
                    $scope.createClientPremium.Age = data;
                    $scope.validationMessage = null;
                })
            }

            $scope.createClientPremium = function (clientPremium) {
                $scope.successMessage = null;
                var dd = String($scope.createClientPremium.Date.getDate()).padStart(2, '0');
                var mm = String($scope.createClientPremium.Date.getMonth() + 1).padStart(2, '0'); //January is 0!
                var yyyy = $scope.createClientPremium.Date.getFullYear();
                var dateString = dd + '/' + mm + '/' + yyyy;
                var clientPremium = {
                    Name: $scope.createClientPremium.Name,
                    Age: $scope.createClientPremium.Age,
                    DateOfBirthStr: dateString,
                    OccupationId: $scope.createClientPremium.OccupationId,
                    DeathSumInsured: $scope.createClientPremium.DeathSumInsured,
                    MonthlyPremium: $scope.createClientPremium.MonthlyPremium
                };
                clientPremiumCreateService.CreatePremiumForClient(clientPremium, function (data) {
                    //$scope.createClientPremium.Age = data;
                    $scope.successMessage = data;
                    $scope.createClientPremium = null;
                })
            }

        }]);

// Get Client Premiums ...
angular.module("ClientPremiumInsurance").service("clientPremiumDataService", ['$http', '$log', function ($http, $log) {
    var path = "/Client/"
    this.GetClientPremiumList = function (callback) {
        $http.get(path + 'GetClientPremiumList')
            .then(function (response) {
                debugger;
                var clientPremiums = response.data;
                angular.forEach(clientPremiums, function (clientPremium) {
                    clientPremium.DateOfBirth = new Date(parseInt(clientPremium.DateOfBirth.substr(6)));
                });
                callback(clientPremiums);
            });
    }
}]);

// Get Client Age
angular.module("ClientPremiumInsurance").service("clientPremiumCalculateAgeService", ['$http', '$log', function ($http, $log) {
    var path = "/Client/"
    this.GetClientAge = function (dob, callback) {
        $http.get(path + 'GetClientAge', { params: { dateOfBirth: dob } })
            .then(function (response) {
                var age = response.data;
                callback(age);
            });
    }
}]);

//Get Client Premium Insurance
angular.module("ClientPremiumInsurance").service("clientPremiumCalculationService", ['$http', '$log', function ($http, $log) {

    var path = "/Client/";
    this.GetMonthlyPremiumForClient = function (calculatePremiumObject, callback) {
        $http.get(path + 'GetMonthlyPremiumForClient', { params: { calculatePremiumObject: calculatePremiumObject } })
            .then(function (response) {
                var premium = response.data;
                callback(premium);
            });
    }
}]);


//Create Client Premium Insurance
angular.module("ClientPremiumInsurance").service("clientPremiumCreateService", ['$http', '$log', function ($http, $log) {

    var path = "/Client/";
    this.CreatePremiumForClient = function (clientPremium, callback) {
        $http.post(path + 'CreatePremiumForClient', clientPremium)
            .then(function (response) {
                var result = "Client Premium successfully saved";
                callback(result);
            });
    }
}]);

