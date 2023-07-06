import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/helpers/logger.dart';
import 'package:to_do_list/providers/counter.dart';
import 'package:to_do_list/providers/tasks.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../helpers/enums.dart';
import '../../../models/task.dart';
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
class NewTaskScreen extends ConsumerStatefulWidget {
  NewTaskScreen({super.key});
  String enteredTask = '';
  DateTime? enteredDate;
  bool hasDate = false;
  Priority priority = Priority.none;
  static const routeName = '/newTask';

  @override
  ConsumerState<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends ConsumerState<NewTaskScreen> {
  Task? arguments;
  late TimeForm timeForm;
  late TextForm textForm;
  late PriorityForm priorityForm;

  bool saveItem() {
    widget.enteredDate = timeForm.selectedDate;
    widget.hasDate = timeForm.hasDate;
    if (!_formKey.currentState!.validate()) {
      log('warning', "Form doesn't save because it is not valide");
      return false;
    }
    _formKey.currentState!.save();
    widget.enteredTask = textForm.text;
    widget.priority = stringToPriority(priorityForm.priority);
    log('info', 'Form saved succesfully');
    return true;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    arguments = ModalRoute.of(context)!.settings.arguments as Task?;
    textForm = TextForm(
      arguments: arguments,
    );
    timeForm = TimeForm(
      arguments: arguments,
    );
    priorityForm = PriorityForm(
      arguments: arguments,
    );
    if (arguments == null) {
      log('info', 'NEW TASK screen');
    } else {
      log('info', 'EDIT TASK screen');
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var uid = const Uuid();
    if (arguments == null) {
      widget.enteredTask = '';
      widget.enteredDate = null;
      widget.hasDate = false;
      widget.priority = Priority.none;
    } else {
      widget.enteredTask = arguments!.text;
      widget.enteredDate = arguments!.date;
      widget.hasDate = arguments!.hasDate;
      widget.priority = arguments!.priority;
    }

    var deleteButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 17),
      child: InkWell(
        onTap: arguments == null
            ? null
            : () async {
                Navigator.of(context).pop();
                await ref.read(allTasksProvider.notifier).deleteTask(arguments!.id)? ref.read(counterProvider.notifier).updateCounter(-1): ref.read(counterProvider.notifier).updateCounter(0);
                log('info', 'Change screen to MainScreen');
              },
        child: Row(
          children: [
            Icon(
              Icons.delete,
              color: arguments == null
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).colorScheme.error,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              AppLocalizations.of(context)!.delete,
              style: TextStyle(
                color: arguments == null
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).colorScheme.error,
                fontSize: 16,
                height: 20 / 16,
              ),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            textForm,
            priorityForm,
            Divider(color: Theme.of(context).dividerTheme.color),
            timeForm,
            Divider(color: Theme.of(context).dividerTheme.color),
            deleteButton,
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            log('info', 'Change screen to MainScreen');
          },
          icon: Icon(
            Icons.close,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        scrolledUnderElevation: 4,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          TextButton(
            onPressed: () async {
              if (saveItem()) {
                Navigator.of(context).pop();
                Task temp = Task(
                  id: arguments == null ? uid.v1() : arguments!.id,
                  text: widget.enteredTask,
                  priority: widget.priority,
                  hasDate: widget.hasDate,
                  doneStatus: arguments == null ? false : arguments!.doneStatus,
                  date: widget.enteredDate,
                );
                arguments == null
                    ? await ref.read(allTasksProvider.notifier).addTask(temp)
                    : await ref.read(allTasksProvider.notifier).updateTask(arguments!.id, temp);
                log('info', 'Change screen to MainScreen');
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                AppLocalizations.of(context)!.save.toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  height: 24 / 14,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
