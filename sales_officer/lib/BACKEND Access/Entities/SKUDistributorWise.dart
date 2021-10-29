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
      json['1'],
      json['2'],
      json['3'],
      json['4'],
      json['5'],
      json['6'],
    );
  }
}
