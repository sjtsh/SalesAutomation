class DistributorOrderItem {
  final int distributorOrderItemID;
  final int distributorOrderID;
  final int SKUID;
  final int primaryItemCount;
  final int secondaryItemCount;
  final int secondaryAlternativeItemCount;

  DistributorOrderItem(
      this.distributorOrderItemID,
      this.distributorOrderID,
      this.SKUID,
      this.primaryItemCount,
      this.secondaryItemCount,
      this.secondaryAlternativeItemCount);

  factory DistributorOrderItem.fromJson(Map<String, dynamic> json) {
    return DistributorOrderItem(
      json['0'],
      json['1'],
      json['2'],
      json['3'],
      json['4'],
      json['5'],
    );
  }
}
