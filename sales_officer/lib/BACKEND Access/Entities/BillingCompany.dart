class BillingCompany {
  final int billingCompanyID;
  String billingCompanyName;
  int? PAN;
  String ? location;
  int? phone;
  final bool deactivated;

  BillingCompany(
      this.billingCompanyID, this.billingCompanyName, this.deactivated,
      {this.PAN, this.location, this.phone});

  factory BillingCompany.fromJson(Map<String, dynamic> json) {
    return BillingCompany(
      int.parse(json['billingCompanyID'].toStringAsFixed(0)),
      json['billingCompanyName'],
      json['deactivated'] == 0 ? false : true,
      PAN: int.tryParse(json['PAN']),
      location: json['location'],
      phone: int.tryParse(json['phone'].toStringAsFixed(0)),
    );
  }
}
