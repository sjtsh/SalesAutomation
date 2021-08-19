class SubGroup {
  final int subGroupID;
  final String productGroupName;
  final String productLineName;
  final String subGroupName;

  SubGroup(this.subGroupID, this.productGroupName, this.productLineName,
      this.subGroupName);

  factory SubGroup.fromJson(Map<String, dynamic> json) {
    return SubGroup(
      json['0'],
      json['1'],
      json['2'],
      json['3'],
    );
  }
}
