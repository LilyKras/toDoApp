import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/providers/counter.dart';
import 'package:to_do_list/providers/tasks.dart';

class DeleteTaskManager {
  final AllTasksNotifier _allTasksNotifier;
  final CounterNotifier _counterNotifier;

  const DeleteTaskManager(
    this._allTasksNotifier,
    this._counterNotifier,
  );

  Future<void> deleteTask(String taskId) async {
    final deleted = await _allTasksNotifier.deleteTask(taskId);
    if (deleted) {
      _counterNotifier.updateCounter(-1);
    }
  }
}


final deleteTaskManager = Provider(
  (ref) => DeleteTaskManager(
    ref.watch(allTasksProvider.notifier),
    ref.watch(counterProvider.notifier),
  ),
);