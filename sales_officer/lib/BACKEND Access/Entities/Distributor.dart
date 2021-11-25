class Distributor {
  final int distributorID; //0
  final String distributorName; //2
  final String distributorType; //3
  final int townID; //4
  final bool deactivated; //18
  String? distributorERPID; //1
  String? ownerName; //5
  int? phone; //6
  int? mobileNumber; //7
  int? PAN; //8
  String? location; //9
  String? img; //10
  String? bankAccountName; //11
  String? bankAccountNumber; //12
  String? bankName; //13
  String? bankAddress; //14
  int? VAT; //15
  double? lat; //16
  double? lng;

  Distributor(this.distributorID, this.distributorName, this.distributorType,
      this.townID, this.deactivated,
      {this.distributorERPID,
        this.ownerName,
        this.phone,
        this.mobileNumber,
        this.PAN,
        this.location,
        this.img,
        this.bankAccountName,
        this.bankAccountNumber,
        this.bankName,
        this.bankAddress,
        this.VAT,
        this.lat,
        this.lng,}); //17

  factory Distributor.fromJson(Map<String, dynamic> json) {
    return Distributor(
        json['distributorID'],
      json['distributorName'],
      json['distributorType'],
        json['deactivated'],
    json['distributorType'],
        distributorERPID:  json['distributorERPID'],
       ownerName:  json['ownerName'],
        phone: json['phone'],
        mobileNumber: json['mobileNumber'],
        PAN: json['PAN'],
        location:  json['location'],
        img:  json['img'],
        bankAccountName: json['bankAccountName'],
        bankAccountNumber: json['bankAccountNumber'],
        bankName: json['bankName'],
        bankAddress: json['bankAddress'],
      VAT: json['VAT'],
      lat: json['lat'],
      lng: json['lng'],
    );

  }
}
