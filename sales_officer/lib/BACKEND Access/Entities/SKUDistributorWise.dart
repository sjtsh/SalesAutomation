class SKUDistributorWise {
  final int SKUDistributorWiseID;
  final int SKUID;
  final int distributorID;
  int? pricingTypeID;
  int? billingCompanyID;
  int inventoryLevel;
  int target;

  SKUDistributorWise(
    this.SKUDistributorWiseID,
    this.SKUID,
    this.distributorID, {
    this.inventoryLevel = 0,
    this.target = 0,
    this.pricingTypeID,
    this.billingCompanyID,
  });

  factory SKUDistributorWise.fromJson(Map<String, dynamic> json) {
    return SKUDistributorWise(
        json['SKUDistributorWiseID'], json['SKUID'], json['distributorID'],
        pricingTypeID: json['pricingTypeID'],
        billingCompanyID: json['billingCompanyID'],
        inventoryLevel: json['inventoryLevel'],
        target: json['target']);
  }
}
