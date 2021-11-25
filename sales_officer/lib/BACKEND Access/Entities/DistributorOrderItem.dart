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
      int.parse(json['distributorOrderID']),
      int.parse(json['SKUID']),
      int.parse(json['primaryItemCount']),
      int.parse(json['alternativeItemCount']),
      int.parse(json['secondaryAlternativeItemCount']),
      json['deactivated'] == 0 ? false : true,
    );
  }
}
