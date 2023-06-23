import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:http/http.dart' as http;

import '../helpers/logger.dart';

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

  void toggleShowDone() async {
    _showUndone = !_showUndone;
    log('info', 'ShowDone module changed');
    notifyListeners();
  }

  void toggleDoneStatus(String id) async {
    final taskIndex = _myTasks.indexWhere((prod) => prod.id == id);
    log('info', 'Change doneStatus for task with id: $id');
    !_myTasks[taskIndex].doneStatus ? _counter += 1 : _counter -= 1;
    _myTasks[taskIndex].doneStatus = !_myTasks[taskIndex].doneStatus;
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    _myTasks.add(task);
    log('info', 'Add new task with id: ${task.id}');
    notifyListeners();
    Uri url = Uri.parse('https://beta.mrdekk.ru/todobackend/list');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer demirelief',
        'Content-Type': 'appplication/json',
      },
    );
    debugPrint(json.decode(response.body).toString());
    var revision = json.decode(response.body)['revision'].toString();
    var obj = {
      'element': {
        'id': task.id, // уникальный идентификатор элемента
        'text': 'blablabla',
        'importance': 'low', // importance = low | basic | important
        'deadline': DateTime.now()
            .millisecondsSinceEpoch, // int64, может отсутствовать, тогда нет
        'done': true,
        'color': '#FFFFFF', // может отсутствовать
        'created_at': DateTime.now().millisecondsSinceEpoch,
        'changed_at': DateTime.now().millisecondsSinceEpoch,
        'last_updated_by': task.id
      }
    };
    final response1 = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer demirelief',
        'X-Last-Known-Revision': revision,
        'Content-Type': 'appplication/json',
      },
      body: json.encode(obj),
    );
    debugPrint(json.decode(response1.body).toString());
  }

  void updateTask(String id, Task newTask) async {
    final taskIndex = _myTasks.indexWhere((prod) => prod.id == id);
    if (taskIndex >= 0) {
      _myTasks[taskIndex] = newTask;
      log('info', 'Update new task with id: $id');
      notifyListeners();
    } else {
      log('warning', 'There is no task with this id: $id');
    }
  }

  void deleteTask(String id) {
    final existingTaskIndex =
        _myTasks.indexWhere((element) => element.id == id);
    if (_myTasks[existingTaskIndex].doneStatus) _counter -= 1;
    _myTasks.removeAt(existingTaskIndex);
    log('info', 'Remove task with id: $id');
    notifyListeners();
  }
}
