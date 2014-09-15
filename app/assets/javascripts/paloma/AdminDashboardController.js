var DashboardController = Paloma.controller('Admin/Dashboard');

DashboardController.prototype.main = function(){
  that = this;
  BigData.initialize();
}
