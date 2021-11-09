class SKUDistributorWise {
  final int SKUDistributorWiseID;
  final int SKUID;
  final int distributorID;
  final int pricingTypeID;
  final int billingCompanyID;
  final int inventoryLevel;
  final int target;

  SKUDistributorWise(
      this.SKUDistributorWiseID,
      this.SKUID,
      this.distributorID,
      this.pricingTypeID,
      this.billingCompanyID,
      this.inventoryLevel,
      this.target);

  factory SKUDistributorWise.fromJson(Map<String, dynamic> json) {
    return SKUDistributorWise(
      json['0'],
      json['1'] == null ? -1: json['1'].round(),
      json['2'] == null ? -1: json['2'].round(),
      json['3'] == null ? -1: json['3'].round(),
      json['4'] == null ? -1: json['4'].round(),
      json['5'] == null ? -1: json['5'].round(),
      json['6'] == null ? -1: json['6'].round(),
    );
  }
}
