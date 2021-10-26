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
      json['0'],
      json['1'] == 0 ? false : true,
      json['2'] == 0 ? false : true,
      json['3'] == 0 ? false : true,
      json['4'] == 0 ? false : true,
    );
  }
}
