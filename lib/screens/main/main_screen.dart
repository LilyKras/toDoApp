import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/screens/main/widgets/task_item.dart';

import '../../helpers/constants.dart';
import '../../providers/task.dart';
import '../new_task/new_task_screen.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  static const routeName = 'main';
  const MainScreen({super.key});

  final _tasksDone = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backLightPrimary,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: backLightPrimary,
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Мои дела",
                      style: TextStyle(
                          color: labelLightPrimary, fontSize: 20, height: 32 / 20),
                    ),
                    Consumer<Tasks>(
                      builder: (context, value, _) => IconButton(
                        padding: const EdgeInsets.only(top: 5),
                        onPressed: () {
                          value.toggleShowDone();
                        },
                        icon: value.showUndone
                            ? const Icon(
                                Icons.visibility,
                                color: blueLight,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: blueLight,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              background: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Выполнено - $_tasksDone", style: const TextStyle(color: labelLightTertiary, fontSize: 16, height: 20/16),)],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                color: backLightSecondary,
                shadowColor: backLightElevated,
                elevation: 10,
                child: Consumer<Tasks>(
                  builder: (ctx, tasks, _) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...tasks.myTasks.map(
                        (val) => TaskItem(task: val),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 58.0, bottom: 10, top:10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              child: const Text("Новое",style: TextStyle(color:labelLightTertiary, fontSize: 16, height: 20/16),),
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    NewTaskScreen.routeName);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(NewTaskScreen.routeName);
        },
        tooltip: 'Add new task',
        child: const Icon(Icons.add, color: whiteLight,),
      ),
    );
  }
}
