class Familiarity {
  final int subGroupID;
  final bool isTrending;
  final bool isNew;
  final bool isPromoted;
  final bool deactivated;

  Familiarity(
    this.subGroupID,
    this.isTrending,
    this.isNew,
    this.isPromoted,
    this.deactivated,
  );

  factory Familiarity.fromJson(Map<String, dynamic> json) {
    return Familiarity(
      json['subGroupID'],
      json['isTrending'] == 0 ? false : true,
      json['isNew'] == 0 ? false : true,
      json['isPromoted'] == 0 ? false : true,
      json['deactivated'] == 0 ? false : true,
    );
  }
}
