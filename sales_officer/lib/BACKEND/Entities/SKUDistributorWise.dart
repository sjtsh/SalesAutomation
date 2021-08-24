class SKUDistributorWise {
  final int SKUDistributorWiseID;
  final int SKUID;
  final int distributorID;
  final String pricingTypeName;
  final int billingCompanyID;
  final String primaryUnit;
  final int primaryCF;
  final String alternativeUnit;
  final int alternativeCF;
  final String secondaryAlternativeUnit;
  final int secondaryAlternativeCF;
  final double MRP;
  final int inventoryLevel;
  final int target;

  SKUDistributorWise(
      this.SKUDistributorWiseID,
      this.SKUID,
      this.distributorID,
      this.pricingTypeName,
      this.billingCompanyID,
      this.primaryUnit,
      this.primaryCF,
      this.alternativeUnit,
      this.alternativeCF,
      this.secondaryAlternativeUnit,
      this.secondaryAlternativeCF,
      this.MRP,
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
      json['7'],
      json['8'],
      json['9'],
      json['10'],
      json['11'],
      json['12'],
      json['13'],
    );
  }
}
