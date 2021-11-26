class ProductGroup {
  final int productGroupID;
  final String productGroupName;
  final bool deactivated;

  ProductGroup(this.productGroupID, this.productGroupName, this.deactivated);

  factory ProductGroup.fromJson(Map<String, dynamic> json) {
    return ProductGroup(
      json['productGroupID'],
      json['productGroupName'],
      json['deactivated'] == 0 ? false : true,
    );
  }
}
