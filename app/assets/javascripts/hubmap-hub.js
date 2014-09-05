function Hub(jsonData){
    this.id = jsonData.id
    this.name = jsonData.name;
    this.created_at = jsonData.created_at;
    this.town = jsonData.town;
    this.postalCode = jsondata.postalCode;
    this.province = jsonData.province;
    this.country = jsonData.country;
    this.latitude = jsonData.latitude;
    this.longitude = jsonData.longitude;
    this.waterPrice = jsonData.waterPrice;
    this.status = jsonData.status;
};