//ADMIN Dashboard Controller
var DashboardController = Paloma.controller('Admin/Dashboard');

DashboardController.prototype.main = function(){
  that = this;
  BigData.initialize();
};

//ADMIN KIOSKS CONTROLLER
var KiosksController = Paloma.controller('Admin/Kiosks');

KiosksController.prototype.show = function(){
  that = this;
  BigData.initialize();
};

KiosksController.prototype.index = function(){
  that = this;
  BigData.initialize();
};

//ADMIN PUMPS CONTROLLER

var PumpsController = Paloma.controller('Admin/Pumps');

PumpsController.prototype.show = function(){
  that = this;
  BigData.initialize();
};

PumpsController.prototype.index = function(){
  that = this;
  BigData.initialize();
};

//ADMIN PROVIDERS CONTROLLER
var ProvidersController = Paloma.controller('Admin/Providers');

ProvidersController.prototype.show = function(){
  that = this;
  BigData.initialize();
};

ProvidersController.prototype.index = function(){
  that = this;
  BigData.initialize();
};
