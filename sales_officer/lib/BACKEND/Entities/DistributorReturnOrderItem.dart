class DistributorReturnOrderItem {
  final int distributorReturnOrderItemID;
  final int distributorReturnOrderID;
  final int SKUID;
  final int primaryItemCount;
  final int alternativeItemCount;
  final int secondaryAlternativeItemCount;
  final String reason;

  DistributorReturnOrderItem(
      this.distributorReturnOrderItemID,
      this.distributorReturnOrderID,
      this.SKUID,
      this.primaryItemCount,
      this.alternativeItemCount,
      this.secondaryAlternativeItemCount,
      this.reason);

  factory DistributorReturnOrderItem.fromJson(Map<String, dynamic> json) {
    return DistributorReturnOrderItem(
      json['0'],
      json['1'],
      json['2'],
      json['3'],
      json['4'],
      json['5'],
      json['6'],
    );
  }
}
