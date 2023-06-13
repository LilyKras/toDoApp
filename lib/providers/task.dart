import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:to_do_list/models/task.dart';

var logger = Logger();

class Tasks with ChangeNotifier {
  bool _showUndone = true;
  final List<Task> _myTasks = [];
  int _counter = 0;

  List<Task> get myTasks {
    if (!_showUndone) {
      return [..._myTasks];
    } else {
      return _myTasks.where((taskItem) => !taskItem.doneStatus).toList();
    }
  }

  int get counter {
    return _counter;
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
    !_myTasks[taskIndex].doneStatus ? _counter += 1 : _counter -= 1;
    _myTasks[taskIndex].doneStatus = !_myTasks[taskIndex].doneStatus;
    notifyListeners();
  }

  void addTask(Task task) {
    _myTasks.add(task);
    logger.i("Add new task with id: ${task.id}");
    notifyListeners();
  }

  void updateTask(String id, Task newTask) async {
    final taskIndex = _myTasks.indexWhere((prod) => prod.id == id);
    if (taskIndex >= 0) {
      _myTasks[taskIndex] = newTask;
      logger.i("Update new task with id: $id");
      notifyListeners();
    } else {
      logger.w("There is no task with this id: $id");
    }
  }

  void deleteTask(String id) {
    final existingTaskIndex =
        _myTasks.indexWhere((element) => element.id == id);
    if (_myTasks[existingTaskIndex].doneStatus) _counter -= 1;
    _myTasks.removeAt(existingTaskIndex);
    logger.i("Remove task with id: $id");
    notifyListeners();
  }

  void addBackTask(String id) {
    final existingTaskIndex =
        _myTasks.indexWhere((element) => element.id == id);
    Task? existingTask = _myTasks[existingTaskIndex];
    _myTasks.insert(existingTaskIndex, existingTask);
  }
}
