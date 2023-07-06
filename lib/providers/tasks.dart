import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/providers/done_tasks.dart';
// import 'package:to_do_list/providers/counter.dart';

import '../data/api/api.dart';
import '../data/local storage/tasks_list_db.dart';
import '../helpers/logger.dart';

class AllTasksNotifier extends StateNotifier<List<Task>> {
  final TaskListAPIStorage _api = TaskListAPIStorage();
  final TaskListDBStorage _sql = TaskListDBStorage();
  int _counter = 0;

  AllTasksNotifier() : super(const []);
  Future<void> addTask(Task task) async {
    state = [...state, task];
    log('info', 'Add new task with id: ${task.id}');
    await _api.addItem(task);
    await _sql.addItem(task);
  }

  Future<void> updateTask(String id, Task newTask) async {
    final taskIndex = state.indexWhere((prod) => prod.id == id);
    if (taskIndex >= 0) {
      List<Task> temp = [];
      for (int i = 0; i < taskIndex; i++) {
        temp.add(state[i]);
      }
      temp.add(newTask);
      for (int i = taskIndex + 1; i < state.length; i++) {
        temp.add(state[i]);
      }
      state = temp;
      log('info', 'Update new task with id: $id');
    } else {
      log('warning', 'There is no task with this id: $id');
    }
    await _api.updateItem(id, newTask);
    await _sql.updateItem(id, newTask);
  }

  Future<void> deleteTask(String id) async {
    final existingTaskIndex = state.indexWhere((element) => element.id == id);
    if (state[existingTaskIndex].doneStatus) _counter -= 1;
    List<Task> temp = [];
    for (int i = 0; i < existingTaskIndex; i++) {
      temp.add(state[i]);
    }
    for (int i = existingTaskIndex + 1; i < state.length; i++) {
      temp.add(state[i]);
    }
    state = temp;
    log('info', 'Remove task with id: $id');
    await _api.removeItem(id);
    await _sql.removeItem(id);
  }

  int getDoneCount() {
    return _counter;
  }

  Future<void> toggleDoneStatus(String id) async {
    final taskIndex = state.indexWhere((prod) => prod.id == id);
    log('info', 'Change doneStatus for task with id: $id');
    !state[taskIndex].doneStatus ? _counter += 1 : _counter -= 1;
    List<Task> temp = [];
    for (int i = 0; i < taskIndex; i++) {
      temp.add(state[i]);
    }
    Task tempTask = state[taskIndex];
    tempTask.doneStatus = !tempTask.doneStatus;
    temp.add(tempTask);
    for (int i = taskIndex + 1; i < state.length; i++) {
      temp.add(state[i]);
    }
    state = temp;
    await _api.updateItem(id, state[taskIndex]);
    await _sql.updateItem(id, state[taskIndex]);
  }
}

final allTasksProvider = StateNotifierProvider((ref) {
  return AllTasksNotifier();
});

final tasksProv = Provider((ref) {
  List <Task> allTasks = ref.watch(allTasksProvider) as List <Task>;
  bool showDone = ref.watch(doneStatusProvider) as bool;

  if (!showDone){
    return allTasks.where((element) => (element.doneStatus == false)).toList();
  }
  else{
    return allTasks;
  }
}
);

