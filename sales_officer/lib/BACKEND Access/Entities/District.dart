class District {
  final int districtID;
  final int areaID;
  final String districtName;
  final bool deactivated;

  District(this.districtID, this.areaID, this.districtName, this.deactivated);

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      json['districtID'],
      json['areaID'] == null ? -1: json['1'].round(),
      json['districtName'] == null ? "null": json['2'],
      json['deactivated'] == 0 ? false : true,
    );
  }
}
