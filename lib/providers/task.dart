import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';

import '../data/api/api.dart';
import '../helpers/enums.dart';
import '../helpers/logger.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

Priority importanceToPriority(String imp) {
  if (imp == 'low') {
    return Priority.low;
  }
  if (imp == 'important') {
    return Priority.hight;
  }
  return Priority.none;
}

class Tasks with ChangeNotifier {
  bool _showUndone = true;
  List<Task> _myTasks = [];
  int _counter = 0;
  TaskListAPIStorage api = TaskListAPIStorage();

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

  Future<void> fetchAndSetTasks() async {
    int tempCounter = 0;
    var tempList = await api.getAll();
    List<Task> loadedTaskLisk = [];
    for (var elem in tempList) {
      var tempTask = Task(
        id: elem['id'],
        text: elem['text'],
        priority: importanceToPriority(elem['importance']),
        hasDate: elem.containsKey('deadline'),
        doneStatus: elem['done'],
        date: elem.containsKey('deadline')
            ? DateTime.fromMillisecondsSinceEpoch(elem['deadline'])
            : null,
      );
      loadedTaskLisk.add(tempTask);
      if (elem['done']) {
        tempCounter += 1;
      }
    }
    _myTasks = loadedTaskLisk;
    _counter = tempCounter;
    notifyListeners();
  }

  Task findById(String id) {
    return _myTasks.firstWhere((task) => task.id == id);
  }

  void toggleShowDone() async {
    _showUndone = !_showUndone;
    log('info', 'ShowDone module changed');
    notifyListeners();
  }

  Future<void> toggleDoneStatus(String id) async {
    final taskIndex = _myTasks.indexWhere((prod) => prod.id == id);
    log('info', 'Change doneStatus for task with id: $id');
    !_myTasks[taskIndex].doneStatus ? _counter += 1 : _counter -= 1;
    _myTasks[taskIndex].doneStatus = !_myTasks[taskIndex].doneStatus;
    notifyListeners();
    await api.updateItem(id, _myTasks[taskIndex]);
  }

  Future<void> addTask(Task task) async {
    _myTasks.add(task);
    log('info', 'Add new task with id: ${task.id}');
    notifyListeners();
    await api.addItem(task);
  }

  Future<void> updateTask(String id, Task newTask) async {
    final taskIndex = _myTasks.indexWhere((prod) => prod.id == id);
    if (taskIndex >= 0) {
      _myTasks[taskIndex] = newTask;
      log('info', 'Update new task with id: $id');
      notifyListeners();
    } else {
      log('warning', 'There is no task with this id: $id');
    }
    await api.updateItem(id, newTask);
  }

  Future<void> deleteTask(String id) async {
    final existingTaskIndex =
        _myTasks.indexWhere((element) => element.id == id);
    if (_myTasks[existingTaskIndex].doneStatus) _counter -= 1;
    _myTasks.removeAt(existingTaskIndex);
    log('info', 'Remove task with id: $id');
    notifyListeners();
    await api.removeItem(id);
  }
}

// Проверка
// TaskListAPIStorage api = TaskListAPIStorage();
// Future<void> clearAll() async {
//   Uri url = Uri.parse('https://beta.mrdekk.ru/todobackend/list');
//   final response = await http.get(
//     url,
//     headers: {
//       'Authorization': 'Bearer demirelief',
//       'Content-Type': 'appplication/json',
//     },
//   );
//   debugPrint(json.decode(response.body)['list'].toString());
//   for (var elem in json.decode(response.body)['list']) {
//     await api.removeItem(elem['id']);
//   }
//   Uri url1 = Uri.parse('https://beta.mrdekk.ru/todobackend/list');
//   final response1 = await http.get(
//     url1,
//     headers: {
//       'Authorization': 'Bearer demirelief',
//       'Content-Type': 'appplication/json',
//     },
//   );
//   debugPrint(json.decode(response1.body)['list'].toString());
// }
