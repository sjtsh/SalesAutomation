class DistributorOrder {
  final int distributorOrderID;
  final int distributorID;
  final int SOID;
  final bool joint;
  final bool orderStatus;
  final String remarks;
  final String dateAndTime;
  final String updatedTime;
  final double lat;
  final double lng;
  final bool deactivated;

  DistributorOrder(
    this.distributorOrderID,
    this.distributorID,
    this.SOID,
    this.joint,
    this.orderStatus,
    this.remarks,
    this.dateAndTime,
    this.updatedTime,
    this.lat,
    this.lng,
    this.deactivated,
  );

  factory DistributorOrder.fromJson(Map<String, dynamic> json) {
    return DistributorOrder(
      json['0'],
      json['1'],
      json['2'],
      json['3'] == 0 ? false : true,
      json['4'] == 0 ? false : true,
      json['5'],
      json['6'],
      json['7'],
      json['8'],
      json['9'],
      json['10'] == 0 ? false : true,
    );
  }
}
