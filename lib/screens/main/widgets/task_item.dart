import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/helpers/constants.dart';
import 'package:to_do_list/providers/task.dart';
import 'package:intl/intl.dart';

import '../../../helpers/enums.dart';
import '../../../models/task.dart';
import '../../new_task/new_task_screen.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    String emojies = "";
    if (task.priority == Priority.hight){
      emojies = "❗";
    }
    if (task.priority == Priority.low){
      emojies = "⬇";
    }
    return Dismissible(
      background: Container(
        color: greenLight,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(10),
        child: const Icon(Icons.done, color: whiteLight),
      ),
      secondaryBackground: Container(
        color: redLight,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(10),
        child: const Icon(Icons.delete, color: whiteLight),
      ),
      key: ValueKey(task),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          debugPrint("Delete");
          Provider.of<Tasks>(context, listen: false).deleteTask(task.id);
        } else {
          debugPrint("Done/Undone");
          Provider.of<Tasks>(context, listen: false).toggleDoneStatus(task.id);
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
                  if (task.doneStatus) ;
                  value.toggleDoneStatus(task.id);
                },
                fillColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return greenLight;
                    } else {
                      return task.priority == Priority.hight ? redLight: supportLightSeparator;
                      
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
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          emojies + task.text,
                          maxLines: 3,
                           style: (task.doneStatus)? const TextStyle(decoration: TextDecoration.lineThrough, color: labelLightTertiary, fontSize: 16, height: 20/16, decorationColor: labelLightTertiary):const TextStyle(color: labelLightPrimary, fontSize: 16, height: 20/16),
                        ),
                      ),
                      if (task.hasDate)
                        Text(DateFormat.yMMMMd("ru").format(task.date!), style: const TextStyle(color:labelLightTertiary, fontSize: 14, height: 20/14),),
                    ],
                  ),
                ),
              ),
              IconButton(
                color: labelLightTertiary,
                icon: const Icon(
                  Icons.info_outline,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(NewTaskScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
