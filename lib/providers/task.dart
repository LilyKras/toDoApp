import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';

import '../helpers/enums.dart';

class Tasks with ChangeNotifier {
  bool _showUndone = true;
  final List<Task> _myTasks = [
    Task(
        id: "1",
        text: "HI",
        priority: Priority.hight,
        hasDate: true,
        date: DateTime.now(),
        doneStatus: true),
    Task(
        id: "2",
        text:
            "HIiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiigggggiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiigggggggggggiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiggggggggggiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii",
        priority: Priority.low,
        hasDate: false,
        doneStatus: true),
  Task(
        id: "222",
        text:
            "HIiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiigggggiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiigggggggggggiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiggggggggggiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii",
        priority: Priority.hight,
        hasDate: true,
        date: DateTime.now(),
        doneStatus: true),
    Task(
        id: "3",
        text: "HIii",
        priority: Priority.none,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "4",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "5",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "6",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "7",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "8",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "1",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "9",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "1",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "10",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "11",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "12",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "13",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: false),
    Task(
        id: "14",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "15",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "1",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "16",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "17",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "18",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "19",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "20",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "21",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "22",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "23",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
    Task(
        id: "24",
        text: "HI",
        priority: Priority.hight,
        hasDate: false,
        doneStatus: true),
  ];

  List<Task> get myTasks {
    if (!_showUndone) {
      return [..._myTasks];
    } else {
      return _myTasks.where((taskItem) => !taskItem.doneStatus).toList();
    }
  }

  bool get showUndone {
    return _showUndone;
  }

  Task findById(String id) {
    return _myTasks.firstWhere((task) => task.id == id);
  }

  void toggleShowDone() {
    _showUndone = !_showUndone;
    notifyListeners();
  }

  void toggleDoneStatus(String id) async {
    final taskIndex = _myTasks.indexWhere((prod) => prod.id == id);
    _myTasks[taskIndex].doneStatus = !_myTasks[taskIndex].doneStatus;
    notifyListeners();
  }

  void addTask(Task task) {
    _myTasks.add(task);
    notifyListeners();
  }

  void updateTask(String id, Task newTask) async {
    final taskIndex = _myTasks.indexWhere((prod) => prod.id == id);
    if (taskIndex >= 0) {
      _myTasks[taskIndex] = newTask;
      notifyListeners();
    } else {
      debugPrint('...');
    }
  }

  void deleteTask(String id) {
    final existingTaskIndex =
        _myTasks.indexWhere((element) => element.id == id);
    _myTasks.removeAt(existingTaskIndex);
    notifyListeners();
  }

  void addBackTask(String id) {
    final existingTaskIndex =
        _myTasks.indexWhere((element) => element.id == id);
    Task? existingTask = _myTasks[existingTaskIndex];
    _myTasks.insert(existingTaskIndex, existingTask);
  }
}
