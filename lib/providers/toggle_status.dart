import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/providers/counter.dart';
import 'package:to_do_list/providers/tasks.dart';

class ToggleTaskManager {
  final AllTasksNotifier _allTasksNotifier;
  final CounterNotifier _counterNotifier;

  const ToggleTaskManager(
    this._allTasksNotifier,
    this._counterNotifier,
  );

  Future<void> toggleTask(String taskId) async {
    final toggled = await _allTasksNotifier.toggleDoneStatus(taskId);
    if (toggled) {
      _counterNotifier.updateCounter(-1);
    }
    else {
      _counterNotifier.updateCounter(1);
    }
  }
}

final toggleTaskManager = Provider(
  (ref) => ToggleTaskManager(
    ref.watch(allTasksProvider.notifier),
    ref.watch(counterProvider.notifier),
  ),
);