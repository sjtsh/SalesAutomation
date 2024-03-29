class SubGroup {
  final int subGroupID;
  final int productGroupID;
  final String subGroupName;
  final bool deactivated;

  SubGroup(this.subGroupID, this.productGroupID,
      this.subGroupName, this.deactivated);

  factory SubGroup.fromJson(Map<String, dynamic> json) {
    return SubGroup(
      json['subGroupID'],
      int.parse(json['productGroupID'].toStringAsFixed(0)) ,
      json['subGroupName'] ,
      json['deactivated'] == 0 ? false : true,
    );
  }
}
