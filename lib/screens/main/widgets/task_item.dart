import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/helpers/constants.dart';
import 'package:to_do_list/providers/task.dart';
import 'package:intl/intl.dart';

import '../../../helpers/enums.dart';
import '../../../models/task.dart';
import '../../save_task/save_task_screen.dart';

var logger = Logger();

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    Icon emojies = Icon(
      Icons.priority_high,
      size: 16,
      color: !task.doneStatus
          // ignore: deprecated_member_use
          ? Theme.of(context).errorColor
          : Theme.of(context).textTheme.bodySmall!.color,
    );
    if (task.priority == Priority.low) {
      emojies = Icon(
        Icons.arrow_downward,
        size: 16,
        color: !task.doneStatus
            ? Theme.of(context).iconTheme.color
            : Theme.of(context).textTheme.bodySmall!.color,
      );
    }
    return Dismissible(
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
      key: ValueKey(task),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return true;
        } else {
          logger.i("Swipe mode is Done/Undone");
          Provider.of<Tasks>(context, listen: false).toggleDoneStatus(task.id);
          logger.i("Toggle showDone mode");
          return false;
        }
      },
      dismissThresholds: const {
        DismissDirection.endToStart: 0.2,
        DismissDirection.startToEnd: 0.2
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          logger.i("Swipe mode is Delete");
          Provider.of<Tasks>(context, listen: false).deleteTask(task.id);
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
                value: task.doneStatus,
                onChanged: (_) {
                  value.toggleDoneStatus(task.id);
                  logger.i("Toggle showDone mode");
                },
                fillColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Theme.of(context).colorScheme.secondary;
                    } else {
                      return task.priority == Priority.hight
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
                              if (task.priority != Priority.none)
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: emojies,
                                ),
                              TextSpan(text: task.text)
                            ],
                            style: (task.doneStatus)
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
                                        .color)
                                : TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    fontSize: 16,
                                    height: 20 / 16),
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      if (task.hasDate)
                        Text(
                          DateFormat.yMMMMd("ru").format(task.date!),
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color,
                              fontSize: 14,
                              height: 20 / 14),
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
                  Navigator.of(context).pushReplacementNamed(
                      NewTaskScreen.routeName,
                      arguments: task);
                  logger.i(
                      "Change screen to SaveScreen, push arguments: Task with id ${task.id}");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
