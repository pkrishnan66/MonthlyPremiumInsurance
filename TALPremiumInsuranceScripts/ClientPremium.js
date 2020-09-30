/// <reference path="../scripts/angular.min.js" />
var myPremiumApp = angular.module("ClientPremiumInsurance", []).
    controller("ClientPremiumController", ['$scope', '$log', 'clientPremiumDataService', 'clientPremiumCalculateAgeService', 'clientPremiumCalculationService',
        function ($scope, $log, clientPremiumDataService, clientPremiumCalculateAgeService, clientPremiumCalculationService) {
            //Declare the scope and properties...
            $scope.clientPremiumList;
            $scope.selectedClientPremium = null;
            $scope.createClientPremium = null;
            $scope.year = 1920;
            $scope.validationMessage = null;
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
                console.log($scope.clientPremium);
                if (!$scope.createClientPremium.DeathInsuredSum || !$scope.createClientPremium.Age ||
                    !$scope.createClientPremium.Occupation) {
                    $scope.createClientPremium.Occupation = 0;
                    $scope.validationMessage = "Death Insured Sum ,Age and Ocuupation are needed";

                }
                else {
                    var calculatePremiumObject = {
                        DeathSumInsured: $scope.createClientPremium.DeathInsuredSum,
                        Age: $scope.createClientPremium.Age,
                        OccupationId: $scope.createClientPremium.Occupation
                    };
                    var calcObj = JSON.stringify(calculatePremiumObject);
                    clientPremiumCalculationService.GetMonthlyPremiumForClient(calcObj, function (data) {
                        $scope.createClientPremium.MonthlyPremium = data;
                    })
                }
                
            }

            $scope.updateAge = function (date) {
                console.log($scope.createClientPremium);
                var year = date.getFullYear();
                console.log(year);
                if (year >= 1920 && year < 2003) {
                    $scope.getClientAge(date);                    
                }
                else {
                    $scope.validationMessage = "Age must be between 18 and 100";
                }

            }
            $scope.getClientAge = function (dob) {
                clientPremiumCalculateAgeService.GetClientAge(dob, function (data) {
                    $scope.createClientPremium.Age = data;
                    $scope.validationMessage = null;
                })
            }            

            $scope.isOccupationDisabled = function () {
                return false;
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




