class BillingCompany {
  final int billingCompanyID;
  final String billingCompanyName;
  final int PAN;
  final String location;
  final int phone;

  BillingCompany(this.billingCompanyID, this.billingCompanyName, this.PAN,
      this.location, this.phone);

  factory BillingCompany.fromJson(Map<String, dynamic> json) {
    return BillingCompany(
      json['0'],
      json['1'],
      json['2'],
      json['3'],
      json['4'],
    );
  }
}
