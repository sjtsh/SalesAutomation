class SKUStock {
  final int SKUStockID; //0
  final int SKUID; //1
  final int distributorID; //2
  final int SOID; //3
  final int primaryStock; //4
  final int alternativeStock; //5
  final int secondaryAlternativeStock; //6
  final String updatedDate; //7
  final double lat; //8
  final double lng; //9
  final bool deactivated; //10

  SKUStock(
    this.SKUStockID,
    this.SKUID,
    this.distributorID,
    this.SOID,
    this.primaryStock,
    this.alternativeStock,
    this.secondaryAlternativeStock,
    this.updatedDate,
    this.lat,
    this.lng,
    this.deactivated,
  );

  factory SKUStock.fromJson(Map<String, dynamic> json) {
    return SKUStock(
      json['0'],
      json['1'] == null ? -1: json['1'].round(),
      json['2'] == null ? -1: json['2'].round(),
      json['3'] == null ? -1: json['3'].round(),
      json['4'] == null ? -1: json['4'].round(),
      json['5'] == null ? -1: json['5'].round(),
      json['6'] == null ? -1: json['6'].round(),
      json['7'] == null ? "null": json['7'],
      json['8'] == null ? -2000.0: json['8'],
      json['9'] == null ? -2000.0: json['9'],
      json['10'] == 0 ? false : true,
    );
  }
}
