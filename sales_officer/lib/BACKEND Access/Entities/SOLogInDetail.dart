class SOLogInDetail {
  final int SOLogInDetailID;
  final int SOID;
  final String date;
  final String logInTime;
  final double logInLat;
  final double logInLng;
   String ?logOutTime;
   double ?logOutLat;
   double ?logOutLng;

  SOLogInDetail(this.SOLogInDetailID, this.SOID, this.date, this.logInTime, this.logInLat, this.logInLng,
      {this.logOutTime, this.logOutLat, this.logOutLng});

  factory SOLogInDetail.fromJson(Map<String, dynamic> json) {
    return SOLogInDetail(
      json['SOLogInDetailID'] ,
      json['SOID'],
      json['date'],
      json['logInTime'],
      json['logInLat'] ,
      json['logInLng'],
      logOutTime: json['logOutTime'] ,
      logOutLat: json['logOutLat'] ,
     logOutLng:  json['logOutLng'] ,
    );
  }
}
