import 'package:flutter/material.dart';

class SO {
  final int SOID;
  final int ASMID;
  final int districtID;
  final String homeLocation;
  final int PAN;
  final String SOName;
  final int phone;
  final String img;
  final String email;
  final String bankAccountName;
  final String bankAccountNumber;
  final String bankName;
  final String bankAddress;
  final bool deactivated;
  final String reportingManager;
  final bool maritalStatus;
  final String gender;
  final String joiningData;
  final String DOB;

  SO(
      this.SOID,
      this.ASMID,
      this.districtID,
      this.homeLocation,
      this.PAN,
      this.SOName,
      this.phone,
      this.img,
      this.email,
      this.bankAccountName,
      this.bankAccountNumber,
      this.bankName,
      this.bankAddress,
      this.deactivated,
      this.reportingManager,
      this.maritalStatus,
      this.gender,
      this.joiningData,
      this.DOB);

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
      json['12'],
      json['13'] == 0 ? false : true,
      json['14'],
      json['15'] == 0 ? false : true,
      json['16'],
      json['17'],
      json['18'],
    );
  }
}
