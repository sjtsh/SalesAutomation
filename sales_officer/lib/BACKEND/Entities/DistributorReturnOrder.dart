class DistributorReturnOrder {
  final int distributorReturnOrderID;
  final int distributorID;
  final int SOID;
  final bool joint;
  final bool returnOrderStatus;
  final String remarks;
  final String dateAndTime;
  final String updatedTime;
  final double lat;
  final double lng;

  DistributorReturnOrder(
      this.distributorReturnOrderID,
      this.distributorID,
      this.SOID,
      this.joint,
      this.returnOrderStatus,
      this.remarks,
      this.dateAndTime,
      this.updatedTime,
      this.lat,
      this.lng);

  factory DistributorReturnOrder.fromJson(Map<String, dynamic> json) {
    return DistributorReturnOrder(
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
    );
  }
}
