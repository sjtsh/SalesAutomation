class SOLogInDetail {
  final int SOLogInDetailID;
  final int SOID;
  final String date;
  final String logInTime;
  final double logInLat;
  final double logInLng;
  final String logOutTime;
  final double logOutLat;
  final double logOutLng;

  SOLogInDetail(this.SOLogInDetailID, this.SOID, this.date, this.logInTime, this.logInLat, this.logInLng, this.logOutTime, this.logOutLat, this.logOutLng);

  factory SOLogInDetail.fromJson(Map<String, dynamic> json) {
    return SOLogInDetail(
      json['0'] == null ? -1: json['0'].round(),
      json['1'] == null ? -1: json['0'].round(),
      json['2'] == null ? "null": json['5'],
      json['3'] == null ? "null": json['5'],
      json['4'] == null ? -2000.0: json['7'],
      json['5'] == null ? -2000.0: json['7'],
      json['6'] == null ? "null": json['5'],
      json['7'] == null ? -2000.0: json['7'],
      json['8'] == null ? -2000.0: json['7'],
    );
  }
}
