import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/helpers/logger.dart';

class ShowDoneNotifier extends StateNotifier<bool> {
  ShowDoneNotifier() : super(false);

  void toggleShowDone() {
    state = !state;
    log('info', 'Change ShowDoneMode to $state');
  }
}

final doneStatusProvider = StateNotifierProvider((ref) {
  return ShowDoneNotifier();
});
