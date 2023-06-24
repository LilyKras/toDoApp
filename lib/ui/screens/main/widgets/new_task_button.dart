import 'package:flutter/material.dart';

import '../../../../helpers/constants.dart';
import '../../../../helpers/logger.dart';
import '../../save_task/save_task_screen.dart';

class NewTaskButton extends StatelessWidget {
  const NewTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () async {
        Navigator.of(context).pushNamed(NewTaskScreen.routeName);
        log('info', 'Change screen to SaveScreen');
      },
      child: const Icon(
        Icons.add,
        color: white,
      ),
    );
  }
}
