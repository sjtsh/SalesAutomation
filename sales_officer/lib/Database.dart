import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';
import 'BACKEND/Entities/SKU.dart';

List<Distributor> searchedDistributorsLocal = [];
List<Distributor> allDistributorsLocal = [];
List<SubGroup> allSubGroupsLocal = [];
List<SKU> allSKULocal = [];
List<SKUDistributorWise> allSKUDistributorWiseLocal = [];
List<SKUStock>? allSKUStocksLocal;
bool? isJoint;
List products = [
  "Chiura",
  "Choco plus",
  "Superfine Chiura",
  "Nutri Nuggets",
  "Green Tea"
];
List sales = [200, 20003, 19000, 200, 30000];

final List<int> dates = [31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30];
final int startDate1 = 3;

List<String> months = [
  "Baisakh",
  "Jestha",
  "Asar",
  "Shrawan",
  "Bhadra",
  "Ashwin",
  "Kartik",
  "Mangsir",
  "Poush",
  "Magh",
  "Falgun",
  "Chaitra"
];
List<String> weeks = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];