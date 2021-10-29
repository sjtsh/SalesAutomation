class Distributor {
  final int distributorID;
  final String distributorERPID;
  final String distributorName;
  final String distributorType;
  final int townID;
  final String ownerName;
  final int phone;
  final int mobileNumber;
  final int PAN;
  final String location;
  final String img;
  final String bankAccountName;
  final String bankAccountNumber;
  final String bankName;
  final String bankAddress;
  final int VAT;
  final double lat;
  final double lng;
  final bool deactivated;

  Distributor(
    this.distributorID,
    this.distributorERPID,
    this.distributorName,
    this.distributorType,
    this.townID,
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
    this.lng,
    this.deactivated,
  );

  factory Distributor.fromJson(Map<String, dynamic> json) {
    return Distributor(
      json['0'],
      json['1'],
      json['2'],
      json['3'],
      json['4'],
      json['5'],
      json['6'],
      json['7'],
      json['8'],
      json['9'],
      json['10'],
      json['11'],
      json['12'],
      json['13'],
      json['14'],
      json['15'],
      json['16'],
      json['17'],
      json['18'] == 0 ? false : true,
    );
  }
}
