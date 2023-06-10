import 'package:flutter/material.dart';
import 'package:to_do_list/helpers/tasks.dart';

import '../../../models/task.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.task});
  final Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        background: Container(
          color: Colors.green,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          child: const Icon(Icons.done, color: Colors.white),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(10),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        key: ValueKey<Task>(widget.task),
        onDismissed: (DismissDirection direction) {
          if (direction == DismissDirection.endToStart) {
            debugPrint("Delete");
            setState(() {
              deleteById(widget.task.id);
            });
          } else {
            debugPrint("Done");
            setState(() {
              widget.task.changeStatus();
            });
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
                onChanged: (_) {
                  setState(() {
                    widget.task.changeStatus();
                  });
                },
                fillColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.green;
                    } else {
                      return Colors.red;
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
                      Text(
                        overflow: TextOverflow.ellipsis,
                        widget.task.text,
                        maxLines: 3,
                      ),
                      Text(widget.task.date.toString()),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Icon(
                  Icons.info_outline,
                  size:20,
                ),
              ),
            ],
          ),
        ),
      );

  }
}
