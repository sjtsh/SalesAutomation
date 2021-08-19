import 'package:sales_officer/BACKEND/Entities/Distributor.dart';
import 'package:sales_officer/BACKEND/Entities/SubGroup.dart';
import 'BACKEND/Entities/SKU.dart';

List<Distributor> searchedDistributorsLocal = [];
List<Distributor> allDistributorsLocal = [];
List<SubGroup> allSubGroupsLocal = [];
List<SKU> allSKULocal = [];
List products = [
  "Chiura",
  "Choco plus",
  "Superfine Chiura",
  "Nutri Nuggets",
  "Green Tea"
];
List sales = [30233, 20003, 19000, 10003, 9003];

// List allProducts = [
//   ["Chiura", "Kurum Kurum Chiura", 177],
//   ["Chiura", "Superfine Chiura", 120],
//   ["Choco Flakes", "Choco Plus", 132],
//   ["Corn Flakes", "Corn Flakes Regular", 121],
//   ["Corn Flakes", "Corn Flakes Sugar Free", 223],
//   ["Corn Flakes", "Corn Flakes Regular", 999],
//   ["Choco Flakes", "Choco Plus", 132],
//   ["Corn Flakes", "Corn Flakes Regular", 121],
//   ["Corn Flakes", "Corn Flakes Sugar Free", 190],
//   ["Chiura", "Kurum Kurum Chiura", 177],
//   ["Chiura", "Superfine Chiura", 120],
//   ["Choco Flakes", "Choco Plus", 132],
//   ["Corn Flakes", "Corn Flakes Regular", 121],
//   ["Corn Flakes", "Corn Flakes Sugar Free", 223],
//   ["Corn Flakes", "Corn Flakes Regular", 999],
//   ["Choco Flakes", "Choco Plus", 132],
//   ["Corn Flakes", "Corn Flakes Regular", 121],
//   ["Corn Flakes", "Corn Flakes Sugar Free", 190],
// ];

List promotedProducts = [
  [
    "Chiura",
    "Kurum Kurum Chiura",
    177,
  ]
];
List newProducts = [
  [
    "Chiura",
    "Superfine Chiura",
    120,
  ]
];
List trendingProducts = [
  [
    "Choco Flakes",
    "Choco Plus",
    132,
  ]
];
List productVariations = [
  "410GM x 45BOX",
  "500GM x 20POUCH",
  "800GM x 8JAR",
];
