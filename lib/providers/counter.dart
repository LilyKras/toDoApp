import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void updateCounter(int sum) {
    state += sum;
  }
}

final counterProvider = StateNotifierProvider((ref) {
  return CounterNotifier();
});
