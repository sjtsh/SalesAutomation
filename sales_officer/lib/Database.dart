import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/Familiarity.dart';
import 'package:sales_officer/BACKEND/Entities/ProductGroup.dart';
import 'package:sales_officer/BACKEND/Entities/ProductLine.dart';
import 'package:sales_officer/BACKEND/Entities/SKUDistributorWise.dart';
import 'package:sales_officer/BACKEND/Entities/SKUStock.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';
import 'BACKEND/Entities/BillingCompany.dart';
import 'BACKEND/Entities/District.dart';
import 'BACKEND/Entities/SKU.dart';
import 'BACKEND/Entities/SO.dart';
import 'BACKEND/Entities/Unit.dart';

List<Distributor> searchedDistributorsLocal = [];
List<Distributor> allDistributorsLocal = [];
List<SubGroup> allSubGroupsLocal = [];
List<SKU> allSKULocal = [];
List<SKUDistributorWise> allSKUDistributorWiseLocal = [];
List<SKUStock>? allSKUStocksLocal;
List<BillingCompany> allBillingCompanysLocal = [];
List<Familiarity> allFamiliaritysLocal = [];
List<Unit> allUnitsLocal = [];
List<ProductLine> allProductLinesLocal = [];
List<ProductGroup> allProductGroupsLocal = [];
List<District> allDistrictsLocal = [];
SO? meSO;
int? meSOID;
String meBeat = "";

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
List options = [
  ["Retailing", true],
  ["Leave", false],
  ["Holiday", false],
  ["Weekly Off", false],
  ["Depot Visit", true],
  ["Distributor Search", true],
  ["Other Activities", true],
  ["Meeting", true],
  ["Training", true],
];
List beats = [
  "Baluwatar",
  "Golfutar",
  "Maharajgunj",
  "Koteshwor 4",
  "Kritipur 1"
];
List billingAmounts = [
  [1, 12000, 46],
  [2, 11000, 46],
  [3, 30000, 60],
  [4, 1400, 1200],
];
