class DistributorReturnOrder {
  final int distributorReturnOrderID;
  final int distributorID;
  final int SOID;
  final bool joint;
  final bool returnOrderStatus;

  final String dateAndTime;
  final String updatedTime;
  final double lat;
  final double lng;
  final bool deactivated;
  String? remarks;

  DistributorReturnOrder(
      this.distributorReturnOrderID,
      this.distributorID,
      this.SOID,
      this.joint,
      this.returnOrderStatus,
      this.dateAndTime,
      this.updatedTime,
      this.lat,
      this.lng,
      this.deactivated,
      {this.remarks});

  factory DistributorReturnOrder.fromJson(Map<String, dynamic> json) {
    return DistributorReturnOrder(
        json['distributorReturnOrderID'],
        json['distributorID'],
        json['SOID'],
        json['joint'] == 0 ? false : true,
        json['returnOrderStatus'],
        json['dateAndTime'],
        json['updatedTime'],
        json['lat'],
        json['lng'],
        json['deactivated'] == 0 ? false : true,
        remarks: json['remarks']);
  }
}
