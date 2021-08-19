class SKU {
  final int SKUID;
  final String pricingTypeName;
  final int subGroupID;
  final int defaultBillingCompanyID;
  final String primaryUnit;
  final int primaryCF;
  final String alternativeUnit;
  final int alternativeCF;
  final String secondaryAlternativeUnit;
  final int secondaryAlternativeCF;
  final String SKUName;
  final double MRP;
  final String img;

  SKU(
      this.SKUID,
      this.pricingTypeName,
      this.subGroupID,
      this.defaultBillingCompanyID,
      this.primaryUnit,
      this.primaryCF,
      this.alternativeUnit,
      this.alternativeCF,
      this.secondaryAlternativeUnit,
      this.secondaryAlternativeCF,
      this.SKUName,
      this.MRP,
      this.img);

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
    );
  }
}
