import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../../../../helpers/constants.dart';
import '../../../../helpers/logger.dart';
import '../../../../navigation/navigator.dart';

class NewTaskButton extends StatelessWidget {
  const NewTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () async {
        changeScreenToNewTaskScreen(context);
        log('info', 'Change screen to SaveScreen');
        FirebaseAnalytics.instance.logEvent(name: 'change_screen');
      },
      child: const Icon(
        Icons.add,
        color: white,
      ),
    );
  }
}
