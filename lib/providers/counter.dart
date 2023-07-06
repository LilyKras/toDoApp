import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task.dart';

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void updateCounter(int sum) {
    state += sum;
  }

  void fetchAndSetCounter(List<Task> tasks) {
    int tempCounter = 0;
    for (var elem in tasks) {
      if (elem.doneStatus) {
        tempCounter += 1;
      }
    }
    state = tempCounter;
  }
}

final counterProvider = StateNotifierProvider((ref) {
  return CounterNotifier();
});
