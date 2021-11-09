class SODistributorConnection {
  final int SOID;
  final int distributorID;

  SODistributorConnection(this.SOID, this.distributorID);

  factory SODistributorConnection.fromJson(Map<String, dynamic> json) {
    return SODistributorConnection(
      json['0'] == null ? -1: json['0'].round(),
      json['1'] == null ? -1: json['1'].round(),
    );
  }
}
