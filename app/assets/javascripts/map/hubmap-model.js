function Kiosk(jsonData){
    this.id = jsonData.id;
    this.name = jsonData.name;
    this.created_at = jsonData.created_at;
    this.latitude = jsonData.latitude;
    this.longitude = jsonData.longitude;
    this.status = jsonData.status_code;
    this.location_id = jsonData.location_id;
};

function Pump(jsonData){
    this.id = this.jsonData.id;
    this.name = jsonData.name;
    this.created_at = jsonData.created_at;
    this.latitude = jsonData.latitude;
    this.longitude = jsonData.longitude;
    this.status = jsonData.status_code;
    this.location_id = jsonData.location_id;
};

function Transaction(jsonData){
    this.id = this.jsonData.id;
    this.transaction_time = jsonData.transaction_time;
    this.location_id = jsonData.location_id;
    this.latitude = jsonData.latitude;
    this.longitude = jsonData.longitude;
    this.rfid_id = jsonData.rfid_id;
    this.starting_credits = jsonData.starting_credits;
    this.ending_credits = jsonData.ending_credits;
    this.transaction_code = jsonData.transaction_code;
    this.amount = jsonData.amount;
    this.error_code = jsonData.error_code;
    this.created_at = jsonData.created_at;
};

