import 'package:jiffy/jiffy.dart';

class TaskCollection {
  final String date;
  final String description;
  final String from;
  final String taskName;
  final String to;
  final int? milliTo;

  const TaskCollection({
    required this.date,
    required this.description,
    required this.from,
    required this.taskName,
    required this.to,
    this.milliTo,
});

  factory TaskCollection.fromCollection(json){
    String localDate = json['date'];
    String localDescription = json['description'];
    int localFrom = json['from'];
    String localTaskName = json['taskName'];
    int localTo = json['to'];

    String newFrom = Jiffy.unixFromMillisecondsSinceEpoch(localFrom).format('hh:mmaa');
    String newTo = Jiffy.unixFromMillisecondsSinceEpoch(localTo).format('hh:mmaa');

    return TaskCollection(
      date: localDate,
      description: localDescription,
      from: newFrom,
      taskName: localTaskName,
      to: newTo,
      milliTo: localTo,
    );
  }

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