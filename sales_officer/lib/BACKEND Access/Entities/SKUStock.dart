class SKUStock {
  final int SKUStockID; //0
  final int SKUID; //1
  final int distributorID; //2
  final int primaryStock; //3
  final int alternativeStock; //4
  final int secondaryAlternativeStock; //5
  final String updatedDate; //6
  final double lat; //7
  final double lng; //8
  final bool deactivated; //9

  SKUStock(
    this.SKUStockID,
    this.SKUID,
    this.distributorID,
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
      json['6'] == null ? "null": json['6'],
      json['7'] == null ? -2000.0: json['7'],
      json['8'] == null ? -2000.0: json['8'],
      json['9'] == 0 ? false : true,
    );
  }
}
