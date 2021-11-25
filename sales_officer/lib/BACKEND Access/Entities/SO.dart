import 'package:flutter/material.dart';

class SO {
  final int SOID; //0
  final int ASMID; //1
  final int districtID; //2
  final String SOName; //5
  final bool deactivated; //13
  final String joiningDate; //17

  String? homeLocation; //3
  int? PAN; //4
  int? phone; //6
  String? img; //7
  String? email; //8
  String? bankAccountName; //9
  String? bankAccountNumber; //10
  String? bankName; //11
  String? bankAddress; //12

  String? reportingManager; //14
  bool? maritalStatus; //15
  String? gender; //16

  String? DOB; //18

  SO(this.SOID, this.ASMID, this.districtID, this.SOName, this.deactivated,
      this.joiningDate,
      {this.homeLocation,
      this.PAN,
      this.phone,
      this.img,
      this.email,
      this.bankAccountName,
      this.bankAccountNumber,
      this.bankName,
      this.bankAddress,
      this.reportingManager,
      this.maritalStatus,
      this.gender,
      this.DOB});

  factory SO.fromJson(Map<String, dynamic> json) {
    return SO(
      json['SOID'],
      int.parse(json['ASMID'].toStringAsFixed(0)),
      int.parse(json['districtID'].toStringAsFixed(0)),
      json['SOName'],
      json['deactivated'] == 0 ? false : true,
      json['joiningDate'],
      homeLocation: json['homeLocation'],
      PAN: int.tryParse(json['PAN'].toStringAsFixed(0)),
      phone: int.tryParse(json['phone'].toStringAsFixed(0)),
      img: json['img'],
      email: json['email'],
      bankAccountName: json['bankAccountName'],
      bankAccountNumber: json['bankAccountNumber'],
      bankName: json['bankName'],
      bankAddress: json['bankAddress'],
      reportingManager: json['reportingManager'],
      maritalStatus: json['maritalStatus'] == 0 ? false : true,
      gender: json['gender'],
      DOB: json['DOB'],
    );
  }
}
