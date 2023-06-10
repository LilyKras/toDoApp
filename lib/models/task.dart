import 'package:to_do_list/helpers/enums.dart';

class Task {
  Task(
      {required this.id,
      required this.text,
      required this.priority,
      required this.hasDate,
      this.date,
      required this.doneStatus});
  final String id;
  final String text;
  final Priority priority;
  final bool hasDate;
  final DateTime? date;
  bool doneStatus;

  void changeStatus(){
    doneStatus = !doneStatus;
  }
}
