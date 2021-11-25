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
      json['distributorReturnOrderItemID'],
      json['distributorReturnOrderID'] == null ? -1: json['1'].round(),
      json['SKUID'] == null ? -1: json['2'].round(),
      json['primaryItemCount'] == null ? -1: json['3'].round(),
      json['alternativeItemCount'] == null ? -1: json['4'].round(),
      json['secondaryAlternativeItemCount'] == null ? -1: json['5'].round(),
      json['reason'] == null ? "null": json['6'],
      json['deactivated'] == 0 ? false : true,
    );
  }
}
