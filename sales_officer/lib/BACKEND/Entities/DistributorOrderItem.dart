class DistributorOrderItem {
  final int distributorOrderItemID;
  final int distributorOrderID;
  final int SKUID;
  final int primaryItemCount;
  final int alternativeItemCount;
  final int secondaryAlternativeItemCount;

  DistributorOrderItem(
      this.distributorOrderItemID,
      this.distributorOrderID,
      this.SKUID,
      this.primaryItemCount,
      this.alternativeItemCount,
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
