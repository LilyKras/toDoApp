import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/providers/tasks.dart';

import 'package:to_do_list/ui/screens/main/widgets/task_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../navigation/navigator.dart';

class TasksList extends ConsumerWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var addNewTask = Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
      child: InkWell(
        onTap: () => changeScreenToNewTaskScreen(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.add,
                color: Theme.of(context).textTheme.bodySmall!.color,
                size: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.newTask,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall!.color,
                      fontSize: 16,
                      height: 20 / 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Theme.of(context).cardTheme.color,
            child: Padding(
              padding: (ref.watch(tasksProv)).isEmpty
                  ? const EdgeInsets.only()
                  : const EdgeInsets.only(top: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...(ref.watch(tasksProv)).map(
                    (val) => TaskItem(task: val),
                  ),
                  addNewTask
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
