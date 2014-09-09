// var HubFunctions = {
//     findKioskById:function(id){
//     for(var i=0; i<this.kiosks.length; i++){
//       if this.kiosks[i].id === id
//         return this.kiosks[i];
//     }
// }

function Kiosk(jsonData){
    this.id = jsonData.id;
    this.type = "kiosk";
    this.name = jsonData.name;
    this.created_at = jsonData.created_at;
    this.latitude = jsonData.latitude;
    this.longitude = jsonData.longitude;
    this.status_code = jsonData.status_code;
    this.location_id = jsonData.location_id;
    this.transactions = [];
};

Kiosk.prototype = {
    parseTransactions: function(transactionData){
        for (var i=0; i < transactionData.length; i++){
            var transaction = new Transaction(transactionData[i]);
            this.transactions.push(transaction);
        }
    },
};

function Pump(jsonData){
    this.id = jsonData.id;
    this.type = "pump";
    this.name = jsonData.name;
    this.created_at = jsonData.created_at;
    this.latitude = jsonData.latitude;
    this.longitude = jsonData.longitude;
    this.status_code = jsonData.status_code;
    this.location_id = jsonData.location_id;
    this.transactions = [];
};

Pump.prototype = {
    parseTransactions: function(transactionData){
        for (var i=0; i < transactionData.length; i++){
            var transaction = new Transaction(transactionData[i]);
            this.transactions.push(transaction);
        }
    }
};

function Transaction(jsonData){
    this.id = jsonData.id;
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
    this.updated_at = jsonData.updated_at;
};
