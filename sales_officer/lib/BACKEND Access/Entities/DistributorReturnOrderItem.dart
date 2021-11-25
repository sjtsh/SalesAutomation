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
      int.parse(json['distributorReturnOrderID']),
      int.parse(json['SKUID']),
      int.parse(json['primaryItemCount']),
      int.parse(json['alternativeItemCount']),
      int.parse(json['secondaryAlternativeItemCount']),
      json['reason'],
      json['deactivated'] == 0 ? false: true,
    );
  }
}
