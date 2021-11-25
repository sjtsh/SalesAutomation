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
    return SKUDistributorWise(json['SKUDistributorWiseID'],
        int.parse(json['SKUID'].toStringAsFixed(0)), int.parse(json['distributorID'].toStringAsFixed(0)),
        pricingTypeID: int.tryParse(json['pricingTypeID'].toStringAsFixed(0)),
        billingCompanyID: int.tryParse(json['billingCompanyID'].toStringAsFixed(0)),
        inventoryLevel: int.tryParse(json['inventoryLevel'].toStringAsFixed(0)) ?? 0,
        target: int.tryParse(json['target'].toStringAsFixed(0)) ?? 0);
  }
}
