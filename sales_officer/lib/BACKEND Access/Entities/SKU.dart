class SKU {
  final int SKUID; //0
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
  final bool deactivated; //14

  String? img; //13
  String? SKUERPID; //1

  SKU(
    this.SKUID,
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
    this.deactivated, {
    this.SKUERPID,
    this.img,
  });

  factory SKU.fromJson(Map<String, dynamic> json) {
    return SKU(
        json['SKUID'],
        int.parse(json['pricingTypeID']),
        int.parse(json['subGroupID']),
        int.parse(json['defaultBillingCompanyID']),
        int.parse(json['primaryUnitID']),
        int.parse(json['primaryCF']),
        int.parse(json['alternativeUnitID']),
        int.parse(json['alternativeCF']),
        int.parse(json['secondaryAlternativeUnitID']),
        int.parse(json['secondaryAlternativeCF']),
        json['SKUName'],
        json['MRP'],
        json['deactivated'] == 0 ? false : true,
        SKUERPID: json['SKUERPID'],
        img: json['img']);
  }
}
