function BigData.Kiosk(jsonData){
    this.id = jsonData.id;
    this.type = "kiosk";
    this.name = jsonData.name;
    this.created_at = jsonData.created_at;
    this.latitude = jsonData.latitude;
    this.longitude = jsonData.longitude;
    this.status_code = jsonData.status_code;
    this.location_id = jsonData.location_id;
};

function BigData.Pump(jsonData){
    this.id = jsonData.id;
    this.type = "pump";
    this.name = jsonData.name;
    this.created_at = jsonData.created_at;
    this.latitude = jsonData.latitude;
    this.longitude = jsonData.longitude;
    this.status_code = jsonData.status_code;
    this.location_id = jsonData.location_id;
};