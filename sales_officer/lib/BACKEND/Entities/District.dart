class District {
  final int districtID;
  final int areaID;
  final String districtName;
  final bool deactivated;

  District(this.districtID, this.areaID, this.districtName, this.deactivated);

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      json['0'],
      json['1'],
      json['2'],
      json['3'],
    );
  }
}
