// DASHBOARD CONTROLLER
var DashboardController = Paloma.controller('Dashboard');

DashboardController.prototype.main = function(){
  that = this;
  BigData.initialize();
};

// KIOSKS CONTROLLER
var KiosksController = Paloma.controller('Kiosks')

KiosksController.prototype.index = function(){
  that = this;
  BigData.initialize();
};

KiosksController.prototype.show = function(){
  that = this;
  BigData.initialize();
};

// PUMPS CONTROLLER

var PumpsController = Paloma.controller('Pumps')

PumpsController.prototype.index = function(){
  that = this;
  BigData.initialize();
};

PumpsController.prototype.show = function(){
  that = this;
  BigData.initialize();
};