class ProductGroup {
  final int productGroupID;
  final String productGroupName;
  final bool deactivated;

  ProductGroup(this.productGroupID, this.productGroupName, this.deactivated);

  factory ProductGroup.fromJson(Map<String, dynamic> json) {
    return ProductGroup(
      json['0'],
      json['1'],
      json['2'] == 0 ? false : true,
    );
  }
}
