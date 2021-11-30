class Task {
  final int taskID;
  final String taskName;

  Task(this.taskID, this.taskName);

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['taskID'],
      json['taskName'],
    );
  }
}
