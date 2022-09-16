class AddTaskData {
  final String date;
  final String description;
  final int from;
  final String taskName;
  final int to;

  const AddTaskData({
    required this.date,
    required this.description,
    required this.from,
    required this.taskName,
    required this.to,
  });

  Map<String, dynamic> toJson(){
    return {
      'date': date,
      'description': description,
      'from': from,
      'taskName': taskName,
      'to': to,
    };
  }
}