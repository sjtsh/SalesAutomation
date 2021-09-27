class ProductLine {
  final int productLineID;
  final String productLineName;

  ProductLine(
    this.productLineID,
    this.productLineName,
  );

  factory ProductLine.fromJson(Map<String, dynamic> json) {
    return ProductLine(
      json['0'],
      json['1'],
    );
  }
}
