import 'package:sales_officer/BACKEND%20Access/Entities/DistributorSale.dart';
import 'BACKEND Access/Entities/BillingCompany.dart';
import 'BACKEND Access/Entities/Distributor.dart';
import 'BACKEND Access/Entities/District.dart';
import 'BACKEND Access/Entities/Familiarity.dart';
import 'BACKEND Access/Entities/ProductGroup.dart';
import 'BACKEND Access/Entities/SKU.dart';
import 'BACKEND Access/Entities/SKUDistributorWise.dart';
import 'BACKEND Access/Entities/SKUStock.dart';
import 'BACKEND Access/Entities/SO.dart';
import 'BACKEND Access/Entities/SODistributorConnection.dart';
import 'BACKEND Access/Entities/SubGroup.dart';
import 'BACKEND Access/Entities/Unit.dart';

List<Distributor> searchedDistributorsLocal = [];
List<Distributor> allDistributorsLocal = [];
List<Distributor> personalDistributorsLocal = [];
List<DistributorSale> allDistributorSalesLocal = [];
List<SubGroup> allSubGroupsLocal = [];
List<SKU> allSKULocal = [];
List<SKUDistributorWise> allSKUDistributorWiseLocal = [];
List<SKUStock>? allSKUStocksLocal;
List<BillingCompany> allBillingCompanysLocal = [];
List<Familiarity> allFamiliaritysLocal = [];
List<Unit> allUnitsLocal = [];
List<ProductGroup> allProductGroupsLocal = [];
List<District> allDistrictsLocal = [];
List<SODistributorConnection> allSODistributorConnectionsLocal = [];
List<double> weeklySalesLocal = [];
List<double> monthlySalesLocal = [];

SO? meSO;
int? meSOID;
int? soLogInDetailID;
bool isRetailing = false;
String meBeat = "";

bool? isJoint;
Map products = {};


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
List<List<double>> nepaliBreaks = [
  [16, 18, 18, 19, 19, 19, 17, 17, 16, 15, 16, 16],
  [
    17,
    19,
    17,
    19,
    18,
    18,
    17,
    17,
    16,
    15,
    15,
    15,
  ],
  [17, 18, 17, 18, 18, 18, 17, 16, 16, 15, 15, 15],
  [17, 18, 17, 18, 18, 18, 16, 16, 15, 14, 15, 15],
  [16, 18, 18, 19, 19, 19, 17, 17, 16, 15, 16, 16],
  [17, 19, 17, 19, 18, 18, 17, 17, 16, 15, 15, 15]
];
List<List<int>> yearBreaks = [
  [2076, 2020, 4],
  [2077, 2021, 4],
  [2078, 2022, 4],
  [2079, 2023, 4],
  [2080, 2024, 4],
  [2081, 2025, 4]
];
