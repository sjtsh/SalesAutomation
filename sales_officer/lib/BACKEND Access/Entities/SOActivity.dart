class SOActivity {
  final int SOActivityID;
  final int SOID;
  final int distributorID;
  final int taskID;
  final String remark;
  final String dateAndTime;

  SOActivity(this.SOActivityID, this.SOID, this.distributorID, this.taskID, this.remark, this.dateAndTime);

  factory SOActivity.fromJson(Map<String, dynamic> json) {
    return SOActivity(
      json['SOActivityID'],
      int.parse(json['SOID'].toStringAsFixed(0)),
      int.parse(json['distributorID'].toStringAsFixed(0)),
      int.parse(json['taskID'].toStringAsFixed(0)),
      json['remark'],
      json['dateAndTime']
    );
  }
}