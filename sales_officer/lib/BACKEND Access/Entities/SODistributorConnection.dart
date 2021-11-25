class SODistributorConnection {
  final int SOID;
  final int distributorID;

  SODistributorConnection(this.SOID, this.distributorID);

  factory SODistributorConnection.fromJson(Map<String, dynamic> json) {
    return SODistributorConnection(
      json['SOID'] ,
      json['distributorID']
    );
  }}
