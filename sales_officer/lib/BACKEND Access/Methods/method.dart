
String getInitials(String distributorName) {
  if (distributorName.split(" ").length >= 2) {
    return distributorName.split(" ")[0].substring(0, 1).toUpperCase() +
        distributorName.split(" ")[1].substring(0, 1).toUpperCase();
  } else {
    return distributorName.split(" ")[0].substring(0, 1).toUpperCase();
  }
}