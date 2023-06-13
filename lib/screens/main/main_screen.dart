import 'package:flutter/material.dart';
import 'package:to_do_list/screens/main/widgets/app_bar.dart';
import 'package:to_do_list/screens/main/widgets/new_task_button.dart';
import 'package:to_do_list/screens/main/widgets/tasks_list.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  static const routeName = 'main';
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // ignore: deprecated_member_use
        backgroundColor: Theme.of(context).backgroundColor,
        body: const CustomScrollView(
          slivers: [
            TaskAppBar(),
            TasksList(),
          ],
        ),
        floatingActionButton: const NewTaskButton());
  }
}
