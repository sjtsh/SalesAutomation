class SKUStock {
  final int SKUStockID;
  final int SKUID;
  final int distributorID;
  final int primaryStock;
  final int alternativeStock;
  final int secondaryAlternativeStock;
  final String updatedDate;
  final double lat;
  final double lng;

  SKUStock(this.SKUStockID, this.SKUID, this.distributorID,
      this.primaryStock, this.alternativeStock, this.secondaryAlternativeStock, this.updatedDate, this.lat, this.lng, );

  factory SKUStock.fromJson(Map<String, dynamic> json) {
    return SKUStock(
      json['0'],
      json['1'],
      json['2'],
      json['3'],
      json['4'],
      json['5'],
      json['6'],
      json['7'],
      json['8'],
    );
  }
}
