class Unit {
  final int unitID;
  final String unitName;

  Unit(this.unitID, this.unitName);

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      json['unitID'],
      json['unitName']
    );
  }
}
