import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/helpers/constants.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_list/providers/delete.dart';

import '../../../../helpers/enums.dart';
import '../../../../helpers/logger.dart';
import '../../../../models/task.dart';
import '../../../../providers/counter.dart';
// import '../../../../providers/delete.dart';
import '../../../../providers/tasks.dart';
import '../../save_task/save_task_screen.dart';

class TaskItem extends ConsumerStatefulWidget {
  const TaskItem({super.key, required this.task});
  final Task task;

  @override
  ConsumerState<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends ConsumerState<TaskItem> {
  late double dismissProgress;

  @override
  void initState() {
    super.initState();

    dismissProgress = 0;
  }

  @override
  Widget build(BuildContext context) {
    Icon emojies = Icon(
      Icons.priority_high,
      size: 16,
      color: !widget.task.doneStatus
          ? false
              ? Theme.of(context).colorScheme.error
              : const Color(0xFF793cd8)
          : Theme.of(context).textTheme.bodySmall!.color,
    );
    if (widget.task.priority == Priority.low) {
      emojies = Icon(
        Icons.arrow_downward,
        size: 16,
        color: !widget.task.doneStatus
            ? Theme.of(context).iconTheme.color
            : Theme.of(context).textTheme.bodySmall!.color,
      );
    }
    return ClipRect(
      child: Dismissible(
        onUpdate: (details) {
          setState(() {
            dismissProgress = details.progress;
          });
        },
        background: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: Viewport(
            axisDirection: AxisDirection.right,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Icon(Icons.done, color: white),
                ),
              )
            ],
            offset: ViewportOffset.fixed(
              dismissProgress * -(MediaQuery.of(context).size.width - 40) + 40,
            ),
          ),
        ),
        secondaryBackground: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Viewport(
            axisDirection: AxisDirection.left,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Icon(Icons.delete, color: white),
                ),
              )
            ],
            offset: ViewportOffset.fixed(
              dismissProgress * -(MediaQuery.of(context).size.width - 40) + 40,
            ),
          ),
        ),
        key: ValueKey(widget.task),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            return true;
          } else {
            log('info', 'Swipe mode is Done/Undone');

            await ref
                    .read(allTasksProvider.notifier)
                    .toggleDoneStatus(widget.task.id)
                ? ref.read(counterProvider.notifier).updateCounter(-1)
                : ref.read(counterProvider.notifier).updateCounter(1);

            return false;
          }
        },
        dismissThresholds: const {
          DismissDirection.endToStart: 0.2,
          DismissDirection.startToEnd: 0.2
        },
        onDismissed: (direction) async {
          if (direction == DismissDirection.endToStart) {
            log('info', 'Swipe mode is Delete');

            await ref.read(deleteTaskManager).deleteTask(widget.task.id);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: widget.task.doneStatus,
                onChanged: (_) async {
                  await ref
                          .read(allTasksProvider.notifier)
                          .toggleDoneStatus(widget.task.id)
                      ? ref.read(counterProvider.notifier).updateCounter(-1)
                      : ref.read(counterProvider.notifier).updateCounter(1);
                },
                fillColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Theme.of(context).colorScheme.secondary;
                    } else {
                      return widget.task.priority == Priority.hight
                          ? false
                              ? Theme.of(context).colorScheme.error
                              : const Color(0xFF793cd8)
                          : Theme.of(context).dividerTheme.color;
                    }
                  },
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              if (widget.task.priority != Priority.none)
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: emojies,
                                ),
                              TextSpan(text: widget.task.text)
                            ],
                            style: (widget.task.doneStatus)
                                ? TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .color,
                                    fontSize: 16,
                                    height: 20 / 16,
                                    decorationColor: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .color,
                                  )
                                : TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    fontSize: 16,
                                    height: 20 / 16,
                                  ),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      if (widget.task.hasDate)
                        Text(
                          DateFormat(
                            'd MMMM y',
                            AppLocalizations.of(context)!.locale,
                          ).format(widget.task.date!),
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall!.color,
                            fontSize: 14,
                            height: 20 / 14,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              IconButton(
                color: Theme.of(context).textTheme.bodySmall!.color,
                icon: const Icon(
                  Icons.info_outline,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    NewTaskScreen.routeName,
                    arguments: widget.task,
                  );
                  log(
                    'info',
                    'Change screen to SaveScreen, push arguments: Task with id ${widget.task.id}',
                  );
                  FirebaseAnalytics.instance.logEvent(name: 'change_screen');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
