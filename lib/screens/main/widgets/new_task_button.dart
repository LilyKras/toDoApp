import 'package:flutter/material.dart';

import '../../../helpers/constants.dart';
import '../../new_task/save_task_screen.dart';

class NewTaskButton extends StatelessWidget {
  const NewTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(NewTaskScreen.routeName);
      },
      tooltip: 'Add new task',
      child: const Icon(
        Icons.add,
        color: white,
      ),
    );
  }
}
