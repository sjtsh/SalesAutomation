class SKU {
  final int SKUID; //0
  final String SKUERPID; //1
  final int pricingTypeID; //2
  final int subGroupID; //3
  final int defaultBillingCompanyID; //4
  final int primaryUnitID; //5
  final int primaryCF; //6
  final int alternativeUnitID; //7
  final int alternativeCF; //8
  final int secondaryAlternativeUnitID; //9
  final int secondaryAlternativeCF; //10
  final String SKUName; //11
  final double MRP; //12
  final String img; //13
  final bool deactivated; //14

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
      json['1'] == null ? "null": json['1'],
      json['2'] == null ? -1: json['2'].round(),
      json['3'] == null ? -1: json['3'].round(),
      json['4'] == null ? -1: json['4'].round(),
      json['5'] == null ? -1: json['5'].round(),
      json['6'] == null ? -1: json['6'].round(),
      json['7'] == null ? -1: json['7'].round(),
      json['8'] == null ? -1: json['8'].round(),
      json['9'] == null ? -1: json['9'].round(),
      json['10'] == null ? -1: json['10'].round(),
      json['11'] == null ? "null": json['11'],
      json['12'] == null ? -2000.0: json['12'],
      json['13'] == null ? "null": json['13'],
      json['14'] == 0 ? false : true,
    );
  }
}
