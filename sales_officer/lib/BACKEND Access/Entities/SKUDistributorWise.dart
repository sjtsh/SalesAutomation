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
        int.parse(json['SKUID']), int.parse(json['distributorID']),
        pricingTypeID: int.tryParse(json['pricingTypeID']),
        billingCompanyID: int.tryParse(json['billingCompanyID']),
        inventoryLevel: int.tryParse(json['inventoryLevel']) ?? 0,
        target: int.tryParse(json['target']) ?? 0);
  }
}
