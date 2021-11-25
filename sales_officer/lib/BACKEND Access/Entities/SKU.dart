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
        int.parse(json['pricingTypeID'].toStringAsFixed(0)),
        int.parse(json['subGroupID'].toStringAsFixed(0)),
        int.parse(json['defaultBillingCompanyID'].toStringAsFixed(0)),
        int.parse(json['primaryUnitID'].toStringAsFixed(0)),
        int.parse(json['primaryCF'].toStringAsFixed(0)),
        int.parse(json['alternativeUnitID'].toStringAsFixed(0)),
        int.parse(json['alternativeCF'].toStringAsFixed(0)),
        int.parse(json['secondaryAlternativeUnitID'].toStringAsFixed(0)),
        int.parse(json['secondaryAlternativeCF'].toStringAsFixed(0)),
        json['SKUName'],
        json['MRP'],
        json['deactivated'] == 0 ? false : true,
        SKUERPID: json['SKUERPID'],
        img: json['img']);
  }
}
