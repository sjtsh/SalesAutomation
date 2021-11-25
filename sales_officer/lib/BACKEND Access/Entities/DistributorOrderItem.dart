class DistributorOrderItem {
  final int distributorOrderItemID;
  final int distributorOrderID;
  final int SKUID;
   final int  primaryItemCount;
  final int alternativeItemCount;
  final int  secondaryAlternativeItemCount;
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
      json['distributorOrderID'] ,
      json['SKUID'] ,
      json['primaryItemCount'] ,
      json['alternativeItemCount'],
      json['secondaryAlternativeItemCount'] ,
      json['deactivated'] == 0 ? false : true,
    );
  }
}
