class Distributor {
  final int distributorID; //0
  final String distributorERPID; //1
  final String distributorName; //2
  final String distributorType; //3
  final int townID; //4
  final String ownerName; //5
  final int phone; //6
  final int mobileNumber; //7
  final int PAN; //8
  final String location; //9
  final String img; //10
  final String bankAccountName; //11
  final String bankAccountNumber; //12
  final String bankName; //13
  final String bankAddress; //14
  final int VAT; //15
  final double lat; //16
  final double lng; //17
  final bool deactivated; //18

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
