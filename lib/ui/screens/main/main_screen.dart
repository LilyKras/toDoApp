import 'package:flutter/material.dart';
import 'package:to_do_list/ui/screens/main/widgets/app_bar.dart';
import 'package:to_do_list/ui/screens/main/widgets/new_task_button.dart';
import 'package:to_do_list/ui/screens/main/widgets/tasks_list.dart';

class MainScreen extends StatelessWidget {
  static const routeName = 'main';
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const CustomScrollView(
        slivers: [
          TaskAppBar(),
          TasksList(),
        ],
      ),
      floatingActionButton: const NewTaskButton(),
    );
  }
}
