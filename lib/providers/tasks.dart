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

  AllTasksNotifier() : super(const []);
  Future<void> addTask(Task task) async {
    state = [...state, task];
    log('info', 'Add new task with id: ${task.id}');
    await _sql.addItem(task);
    _api.addItem(task);
    
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
    await _sql.updateItem(id, newTask);
    _api.updateItem(id, newTask);

  }

  Future<bool> deleteTask(String id) async {
    bool hasDec = false;
    final existingTaskIndex = state.indexWhere((element) => element.id == id);
    if (state[existingTaskIndex].doneStatus) {
      hasDec = true;
    }
    List<Task> temp = [];
    for (int i = 0; i < existingTaskIndex; i++) {
      temp.add(state[i]);
    }
    for (int i = existingTaskIndex + 1; i < state.length; i++) {
      temp.add(state[i]);
    }
    state = temp;
    log('info', 'Remove task with id: $id');
    await _sql.removeItem(id);
    _api.removeItem(id);


    return hasDec;
  }

  Future<bool> toggleDoneStatus(String id) async {
    bool hasDec = false;
    final taskIndex = state.indexWhere((prod) => prod.id == id);
    log('info', 'Change doneStatus for task with id: $id');
    !state[taskIndex].doneStatus ? hasDec = false : hasDec = true;
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
    
    await _sql.updateItem(id, state[taskIndex]);
    _api.updateItem(id, state[taskIndex]);
    return hasDec;
  }

  Future<void> fetchAndSetTasks() async {
    // await patch();
    state = await _sql.getAll();
  }
}

final allTasksProvider = StateNotifierProvider((ref) {
  return AllTasksNotifier();
});

final tasksProv = Provider((ref) {
  List<Task> allTasks = ref.watch(allTasksProvider) as List<Task>;
  bool showDone = ref.watch(doneStatusProvider) as bool;

  if (!showDone) {
    return allTasks.where((element) => (element.doneStatus == false)).toList();
  } else {
    return allTasks;
  }
});
