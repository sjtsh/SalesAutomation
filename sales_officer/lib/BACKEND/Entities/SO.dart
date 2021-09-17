import 'package:flutter/material.dart';

class SO {
  final int SOID;
  final int ASMID;
  final String districtName;
  final String homeLocation;
  final int PAN;
  final String SOName;
  final int phone;
  final String img;
  final String email;
  final String bankAccountName;
  final int bankAccountNumber;
  final String bankName;
  final bool deactivated;
  final String reportingManager;

  SO(this.SOID, this.ASMID, this.districtName, this.homeLocation, this.PAN, this.SOName, this.phone, this.img, this.email, this.bankAccountName, this.bankAccountNumber, this.bankName, this.deactivated, this.reportingManager);

  factory SO.fromJson(Map<String, dynamic> json) {
    return SO(
        json['0'],
        json['1'],
        json['2'],
        json['3'],
        json['4'],
        json['5'],
        json['6'],
        json['7'],
        json['8'],
        json['9'],
        json['10'],
        json['11'],
        json['12'] == 0 ? false:true,
        json['13']);
  }
}
