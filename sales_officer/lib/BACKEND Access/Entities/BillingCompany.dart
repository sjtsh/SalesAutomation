class BillingCompany {
  final int billingCompanyID;
  final String billingCompanyName;
  final int PAN;
  final String location;
  final int phone;
  final bool deactivated;

  BillingCompany(this.billingCompanyID, this.billingCompanyName, this.PAN,
      this.location, this.phone, this.deactivated);

  factory BillingCompany.fromJson(Map<String, dynamic> json) {
    return BillingCompany(
      json['0'],
      json['1'] == null ? "null": json['1'],
      json['2'] == null ? -1: json['2'].round(),
      json['3'] == null ? "null": json['3'],
      json['4'] == null ? -1: json['4'].round(),
      json['5'] == 0 ? false : true,
    );
  }
}
