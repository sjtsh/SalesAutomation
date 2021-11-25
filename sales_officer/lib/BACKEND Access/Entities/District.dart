class District {
  final int districtID;
  final int areaID;
  final String districtName;
  final bool deactivated;

  District(this.districtID, this.areaID, this.districtName, this.deactivated);

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      json['districtID'],
      int.parse(json['areaID'].toStringAsFixed(0)),
      json['districtName'],
      json['deactivated'] == 0 ? false : true,
    );
  }
}
