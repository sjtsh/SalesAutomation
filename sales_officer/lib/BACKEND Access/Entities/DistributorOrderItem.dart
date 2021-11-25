class DistributorOrderItem {
  final int distributorOrderItemID;
  final int distributorOrderID;
  final int SKUID;
  final int primaryItemCount;
  final int alternativeItemCount;
  final int secondaryAlternativeItemCount;
  final bool deactivated;

  DistributorOrderItem(
    this.distributorOrderItemID,
    this.distributorOrderID,
    this.SKUID,
    this.primaryItemCount,
    this.alternativeItemCount,
    this.secondaryAlternativeItemCount,
    this.deactivated,
  );

  factory DistributorOrderItem.fromJson(Map<String, dynamic> json) {
    return DistributorOrderItem(
      json['distributorOrderItemID'],
      int.parse(json['distributorOrderID'].toStringAsFixed(0)),
      int.parse(json['SKUID'].toStringAsFixed(0)),
      int.parse(json['primaryItemCount'].toStringAsFixed(0)),
      int.parse(json['alternativeItemCount'].toStringAsFixed(0)),
      int.parse(json['secondaryAlternativeItemCount'].toStringAsFixed(0)),
      json['deactivated'] == 0 ? false : true,
    );
  }
}
