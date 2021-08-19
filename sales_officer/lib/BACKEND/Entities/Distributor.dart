
class Distributor {
  final int distributorID;
  final String distributorName;
  final String ownerName;
  final int phone;
  final int mobileNumber;
  final int PAN;
  final String location;
  final String img;
  final String bankAccountName;
  final int bankAccountNumber;
  final String bankAddress;
  final int VAT;
  final double lat;
  final double lng;

  Distributor(
      this.distributorID,
      this.distributorName,
      this.ownerName,
      this.phone,
      this.mobileNumber,
      this.PAN,
      this.location,
      this.img,
      this.bankAccountName,
      this.bankAccountNumber,
      this.bankAddress,
      this.VAT,
      this.lat,
      this.lng);

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
        json['13']);
  }
}
