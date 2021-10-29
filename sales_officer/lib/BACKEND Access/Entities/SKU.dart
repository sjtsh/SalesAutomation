class SKU {
  final int SKUID;
  final String SKUERPID;
  final int pricingTypeID;
  final int subGroupID;
  final int defaultBillingCompanyID;
  final int primaryUnitID;
  final int primaryCF;
  final int alternativeUnitID;
  final int alternativeCF;
  final int secondaryAlternativeUnitID;
  final int secondaryAlternativeCF;
  final String SKUName;
  final double MRP;
  final String img;
  final bool deactivated;

  SKU(
    this.SKUID,
    this.SKUERPID,
    this.pricingTypeID,
    this.subGroupID,
    this.defaultBillingCompanyID,
    this.primaryUnitID,
    this.primaryCF,
    this.alternativeUnitID,
    this.alternativeCF,
    this.secondaryAlternativeUnitID,
    this.secondaryAlternativeCF,
    this.SKUName,
    this.MRP,
    this.img,
    this.deactivated,
  );

  factory SKU.fromJson(Map<String, dynamic> json) {
    return SKU(
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
      json['14'] == 0 ? false : true,
    );
  }
}
