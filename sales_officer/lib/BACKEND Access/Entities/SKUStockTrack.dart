import 'package:flutter/material.dart';

class SKUStockTrack {
  final int SKUStockTrackID;
  final int SOID;
  final int distributorID;
  final String dateAndTime;

  SKUStockTrack(
      this.SKUStockTrackID, this.SOID, this.distributorID, this.dateAndTime);

  factory SKUStockTrack.fromJson(Map<String, dynamic> json) {
    return SKUStockTrack(
      json['SKUStockTrackID'],
      int.parse(json['SOID'].toStringAsFixed(0)),
      int.parse(json['distributorID'].toStringAsFixed(0)),
      json['dateAndTime'],
    );
  }
}
