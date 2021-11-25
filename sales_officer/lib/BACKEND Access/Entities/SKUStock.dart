class SKUStock {
  final int SKUStockID; //0
  final int SKUID; //1
  final int distributorID; //2
  final int SOID; //3

  final bool deactivated; //10
  int primaryStock; //4
  int alternativeStock; //5
  int secondaryAlternativeStock; //6
  String updatedDate; //7
  double? lat; //8
  double? lng; //9

  SKUStock(
    this.SKUStockID,
    this.SKUID,
    this.distributorID,
    this.SOID,
    this.deactivated, {
    this.primaryStock = 0,
    this.alternativeStock = 0,
    this.secondaryAlternativeStock = 0,
    this.updatedDate = "0000-00-00 00:00:00",
    this.lat,
    this.lng,
  });

  factory SKUStock.fromJson(Map<String, dynamic> json) {
    return SKUStock(
      json['SKUStockID'],
      int.parse(json['SKUID'].toStringAsFixed(0)),
      int.parse(json['distributorID'].toStringAsFixed(0)),
      int.parse(json['SOID'].toStringAsFixed(0)),
      json['deactivated'] == 0 ? false : true,
      primaryStock: int.tryParse(json['primaryStock'].toStringAsFixed(0)) ?? 0,
      alternativeStock:
          int.tryParse(json['alternativeStock'].toStringAsFixed(0)) ?? 0,
      secondaryAlternativeStock:
          int.tryParse(json['secondaryAlternativeStock'].toStringAsFixed(0)) ??
              0,
      updatedDate: json['updatedDate'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
