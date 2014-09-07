function Kiosk(jsonData){
    this.id = this.jsonData.id;
    this.name = jsonData.name;
    this.created_at = jsonData.created_at;
    this.latitude = jsonData.latitude;
    this.longitude = jsonData.longitude;
    this.status = jsonData.status_code;
    this.location_id = jsonDate.location_id;
};

function Pump(jsonData){
    this.id = this.jsonData.id;
    this.name = jsonData.name;
    this.created_at = jsonData.created_at;
    this.latitude = jsonData.latitude;
    this.longitude = jsonData.longitude;
    this.status = jsonData.status_code;
    this.location_id = jsonDate.location_id;
};

function Transaction(jsonData){
    this.id = this.jsonDate.id;
    this.transaction_time = jsonDate.transaction_time;
    this.location_id = jsonDate.location_id;
    this.latitude = jsonData.latitude;
    this.longitude = jsonData.longitude;
    this.rfid_id = jsonData.rfid_id;
    this.starting_credits = jsonDate.starting_credits;
    this.ending_credits = jsonDate.ending_credits;
    this.transaction-code = jsonDate.transaction_code;
    this.amount = jsonDate.amount;
    this.error_code = jsonDate.error_code;
    this.created_at = jsonDate.created_at;
};

