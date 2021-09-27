class SubGroup {
  final int subGroupID;
  final int productGroupID;
  final int productLineID;
  final String subGroupName;
  final bool deactivated;

  SubGroup(this.subGroupID, this.productGroupID, this.productLineID,
      this.subGroupName, this.deactivated);

  factory SubGroup.fromJson(Map<String, dynamic> json) {
    return SubGroup(
      json['0'],
      json['1'],
      json['2'],
      json['3'],
      json['4'] == 0 ? false : true,
    );
  }
}
