import 'package:flutter/material.dart';

import '../ui/screens/save_task/save_task_screen.dart';

void changeScreenToNewTaskScreen(BuildContext context, [arguments]) {
  arguments != null
      ? Navigator.of(context).pushNamed(
          NewTaskScreen.routeName,
          arguments: arguments,
        )
      : Navigator.of(context).pushNamed(
          NewTaskScreen.routeName,
        );
}

void changeScreenToMainScreen(BuildContext context) {
  Navigator.of(context).pop();
}
