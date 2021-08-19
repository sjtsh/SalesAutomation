class DistributorOrder {
  final int distributorOrderID;
  final int distributorID;
  final int SOID;
  final bool joint;
  final bool orderStatus;
  final String remarks;
  final String dateAndTime;

  DistributorOrder(
      this.distributorOrderID,
      this.distributorID,
      this.SOID,
      this.joint,
      this.orderStatus,
      this.remarks,
      this.dateAndTime);

  factory DistributorOrder.fromJson(Map<String, dynamic> json) {
    return DistributorOrder(
      json['0'],
      json['1'],
      json['2'],
      json['3'] == 0 ? true : false,
      json['4'] == 0 ? true : false,
      json['5'],
      json['6'],
    );
  }
}
