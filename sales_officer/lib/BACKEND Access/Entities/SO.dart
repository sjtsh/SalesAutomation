import 'package:flutter/material.dart';

class SO {
  final int SOID; //0
  final int ASMID; //1
  final int districtID;//2
  final String homeLocation;//3
  final int PAN;//4
  final String SOName;//5
  final int phone;//6
  final String img;//7
  final String email;//8
  final String bankAccountName;//9
  final String bankAccountNumber;//10
  final String bankName;//11
  final String bankAddress;//12
  final bool deactivated;//13
  final String reportingManager;//14
  final bool maritalStatus;//15
  final String gender;//16
  final String joiningDate;//17
  final String DOB;//18

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
      this.joiningDate,
      this.DOB);

  factory SO.fromJson(Map<String, dynamic> json) {
    return SO(
      json['0'],
      json['1'] == null ? -1: json['1'].round(),
      json['2'] == null ? -1: json['2'].round(),
      json['3'] == null ? "null": json['3'],
      json['4'] == null ? -1: json['4'].round(),
      json['5'] == null ? "null": json['5'],
      json['6'] == null ? -1: json['6'].round(),
      json['7'] == null ? "null": json['7'],
      json['8'] == null ? "null": json['8'],
      json['9'] == null ? "null": json['9'],
      json['10'] == null ? "null": json['10'],
      json['11'] == null ? "null": json['11'],
      json['12'] == null ? "null": json['12'],
      json['13'] == 0 ? false : true,
      json['14'] == null ? "null": json['14'],
      json['15'] == 0 ? false : true,
      json['16'] == null ? "null": json['16'],
      json['17'] == null ? "null": json['17'],
      json['18'] == null ? "null": json['18'],
    );
  }
}
