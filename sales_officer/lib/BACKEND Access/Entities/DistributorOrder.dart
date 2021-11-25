class DistributorOrder {
  final int distributorOrderID;
  final int distributorID;
  final int SOID;
  final bool joint;
  final bool orderStatus;
  final String dateAndTime;
  final String updatedTime;
  final double lat;
  final double lng;
  final bool deactivated;
  String? remarks;

  DistributorOrder(
      this.distributorOrderID,
      this.distributorID,
      this.SOID,
      this.joint,
      this.orderStatus,
      this.dateAndTime,
      this.updatedTime,
      this.lat,
      this.lng,
      this.deactivated,
      {this.remarks});

  factory DistributorOrder.fromJson(Map<String, dynamic> json) {
    return DistributorOrder(
      json['distributorOrderID'],
      int.parse(json['distributorID']),
      int.parse(json['SOID']),
      json['joint'] == 0 ? false : true,
      json['orderStatus'] == 0 ? false : true,
      json['dateAndTime'],
      json['updatedTime'],
      json['lat'],
      json['lng'],
      json['deactivated'] == 0 ? false : true,
      remarks: json['remarks'],
    );
  }
}
