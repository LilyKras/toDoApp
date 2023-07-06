import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowDoneNotifier extends StateNotifier<bool> {
  ShowDoneNotifier() : super(false);

  void toggleShowDone() {
    state = !state;
  }
}

final doneStatusProvider = StateNotifierProvider((ref) {
  return ShowDoneNotifier();
});
