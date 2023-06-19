import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/helpers/constants.dart';
import 'package:to_do_list/providers/task.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../../helpers/enums.dart';
import '../../../models/task.dart';
import '../../save_task/save_task_screen.dart';

var logger = Logger();

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.task});
  final Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
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
          // ignore: deprecated_member_use
          ? Theme.of(context).errorColor
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
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          child: const Icon(Icons.done, color: white),
        ),
        secondaryBackground: Container(
          // ignore: deprecated_member_use
          color: Theme.of(context).errorColor,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(10),
          child: const Icon(Icons.delete, color: white),
        ),
        key: ValueKey(widget.task),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            return true;
          } else {
            logger.i('Swipe mode is Done/Undone');
            Provider.of<Tasks>(context, listen: false)
                .toggleDoneStatus(widget.task.id);
            logger.i('Toggle showDone mode');
            return false;
          }
        },
        dismissThresholds: const {
          DismissDirection.endToStart: 0.2,
          DismissDirection.startToEnd: 0.2
        },
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            logger.i('Swipe mode is Delete');
            Provider.of<Tasks>(context, listen: false)
                .deleteTask(widget.task.id);
          }
        },
        child: Consumer<Tasks>(
          builder: (ctx, value, _) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: widget.task.doneStatus,
                  onChanged: (_) {
                    value.toggleDoneStatus(widget.task.id);
                    logger.i('Toggle showDone mode');
                  },
                  fillColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Theme.of(context).colorScheme.secondary;
                      } else {
                        return widget.task.priority == Priority.hight
                            // ignore: deprecated_member_use
                            ? Theme.of(context).errorColor
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
                            DateFormat('d MMMM y', 'ru')
                                .format(widget.task.date!),
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color,
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
                    logger.i(
                      'Change screen to SaveScreen, push arguments: Task with id ${widget.task.id}',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
