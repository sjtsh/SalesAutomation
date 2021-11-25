class SKU {
  final int SKUID; //0
  String SKUERPID; //1
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
    this.deactivated, {
    this.img,
  });

  factory SKU.fromJson(Map<String, dynamic> json) {
    return SKU(
        json['SKUID'],
        json['SKUERPID'],
        json['pricingTypeID'],
        json['subGroupID'],
        json['defaultBillingCompanyID'],
        json['primaryUnitID'],
        json['primaryCF'],
        json['alternativeUnitID'],
        json['alternativeCF'],
        json['secondaryAlternativeUnitID'],
        json['secondaryAlternativeCF'],
        json['SKUName'],
        json['MRP'],
        json['deactivated'] == 0 ? false : true,
        img: json['img']);
  }
}
