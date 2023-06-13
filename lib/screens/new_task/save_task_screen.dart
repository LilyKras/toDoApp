import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/screens/main/main_screen.dart';

import '../../helpers/enums.dart';
import '../../models/task.dart';
import '../../providers/task.dart';
import 'form/priority_form.dart';
import 'form/text_form.dart';
import 'form/time_form.dart';

Priority stringToPriority(String priority) {
  if (priority == '‼ Высокий') {
    return Priority.hight;
  }
  if (priority == 'Низкий') {
    return Priority.low;
  }
  return Priority.none;
}

// ignore: must_be_immutable
class NewTaskScreen extends StatefulWidget {
  NewTaskScreen({super.key});
  String enteredTask = "";
  DateTime? enteredDate;
  bool hasDate = false;
  Priority priority = Priority.none;
  static const routeName = 'new_task';

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  Task? arguments;
  late TimeForm timeForm;
  var textForm = TextForm();
  var priorityForm = PriorityForm();

  bool saveItem() {
    widget.enteredDate = timeForm.selectedDate;
    widget.hasDate = timeForm.hasDate;
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    _formKey.currentState!.save();
    widget.enteredTask = textForm.text;
    widget.priority = stringToPriority(priorityForm.priority);
    return true;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    arguments = ModalRoute.of(context)!.settings.arguments as Task?;
    if (arguments == null) {
      debugPrint("NEW TASK");
    } else {
      debugPrint("EDIT TASK");
    }
    super.didChangeDependencies();
  }
  @override
  void initState() {
    timeForm = TimeForm(arguments:arguments);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (arguments == null) {
      widget.enteredTask = "";
      widget.enteredDate = null;
      widget.hasDate = false;
      widget.priority = Priority.none;
    } else {
      widget.enteredTask = arguments!.text;
      widget.enteredDate = arguments!.date;
      widget.hasDate = arguments!.hasDate;
      widget.priority = arguments!.priority;
    }
    return Scaffold(
      // ignore: deprecated_member_use
      backgroundColor: Theme.of(context).backgroundColor,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            textForm,
            priorityForm,
            Divider(color: Theme.of(context).dividerTheme.color),
            timeForm,
            Divider(color: Theme.of(context).dividerTheme.color),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: arguments == null
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).errorColor,
                  ),
                  TextButton(
                    onPressed: arguments == null
                        ? null
                        : () {
                            Navigator.of(context)
                                .pushReplacementNamed(MainScreen.routeName);
                            Provider.of<Tasks>(context, listen: false)
                                .deleteTask(arguments!.id);
                          },
                    child: Text(
                      "Удалить",
                      style: TextStyle(
                          color: arguments == null
                              ? Theme.of(context).disabledColor
                              : Theme.of(context).errorColor,
                          fontSize: 16,
                          height: 20 / 16),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(MainScreen.routeName);
              },
              icon: Icon(
                Icons.close,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            TextButton(
              onPressed: () {
                if (saveItem()) {
                  Task temp = Task(
                      id: arguments == null? DateTime.now().toString():arguments!.id,
                      text: widget.enteredTask,
                      priority: widget.priority,
                      hasDate: widget.hasDate,
                      doneStatus: arguments == null? false :arguments!.doneStatus,
                      date: widget.enteredDate);
                  arguments == null? Provider.of<Tasks>(context, listen: false).addTask(temp) : Provider.of<Tasks>(context, listen: false).updateTask(arguments!.id, temp);
                  Navigator.of(context)
                      .pushReplacementNamed(MainScreen.routeName);
                }
              },
              child: Text(
                "Сохранить".toUpperCase(),
                style: TextStyle(
                    fontSize: 14,
                    height: 24 / 14,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
