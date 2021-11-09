class DistributorReturnOrderItem {
  final int distributorReturnOrderItemID;
  final int distributorReturnOrderID;
  final int SKUID;
  final int primaryItemCount;
  final int alternativeItemCount;
  final int secondaryAlternativeItemCount;
  final String reason;
  final bool deactivated;

  DistributorReturnOrderItem(
    this.distributorReturnOrderItemID,
    this.distributorReturnOrderID,
    this.SKUID,
    this.primaryItemCount,
    this.alternativeItemCount,
    this.secondaryAlternativeItemCount,
    this.reason,
    this.deactivated,
  );

  factory DistributorReturnOrderItem.fromJson(Map<String, dynamic> json) {
    return DistributorReturnOrderItem(
      json['0'],
      json['1'] == null ? -1: json['1'].round(),
      json['2'] == null ? -1: json['2'].round(),
      json['3'] == null ? -1: json['3'].round(),
      json['4'] == null ? -1: json['4'].round(),
      json['5'] == null ? -1: json['5'].round(),
      json['6'] == null ? "null": json['6'],
      json['7'] == 0 ? false : true,
    );
  }
}
