import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/helpers/logger.dart';
import 'package:to_do_list/providers/tasks.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../helpers/enums.dart';
import '../../../models/task.dart';
import '../../../providers/delete.dart';
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

class NewTaskScreen extends ConsumerStatefulWidget {
  const NewTaskScreen({super.key});

  static const routeName = '/newTask';

  @override
  ConsumerState<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends ConsumerState<NewTaskScreen> {
  Task? arguments;
  late TimeForm timeForm;
  late TextForm textForm;
  late PriorityForm priorityForm;

  String enteredTask = '';
  DateTime? enteredDate;
  bool hasDate = false;
  Priority priority = Priority.none;

  bool saveItem() {
    enteredDate = timeForm.selectedDate;
    hasDate = timeForm.hasDate;
    if (!_formKey.currentState!.validate()) {
      log('warning', "Form doesn't save because it is not valide");
      return false;
    }
    _formKey.currentState!.save();
    enteredTask = textForm.text;
    priority = stringToPriority(priorityForm.priority);
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
      enteredTask = '';
      enteredDate = null;
      hasDate = false;
      priority = Priority.none;
    } else {
      enteredTask = arguments!.text;
      enteredDate = arguments!.date;
      hasDate = arguments!.hasDate;
      priority = arguments!.priority;
    }

    var deleteButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 17),
      child: InkWell(
        onTap: arguments == null
            ? null
            : () async {
                Navigator.of(context).pop();

                await ref.read(deleteTaskManager).deleteTask(arguments!.id);

                log('info', 'Change screen to MainScreen');
                FirebaseAnalytics.instance.logEvent(name: 'change_screen');
              },
        child: Row(
          children: [
            Icon(
              Icons.delete,
              color: arguments == null
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).colorScheme.surface,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              AppLocalizations.of(context)!.delete,
              style: TextStyle(
                color: arguments == null
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).colorScheme.surface,
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
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Form(
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
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            log('info', 'Change screen to MainScreen');
            FirebaseAnalytics.instance.logEvent(name: 'change_screen');
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
                  text: enteredTask,
                  priority: priority,
                  hasDate: hasDate,
                  doneStatus: arguments == null ? false : arguments!.doneStatus,
                  date: enteredDate,
                );
                arguments == null
                    ? await ref.read(allTasksProvider.notifier).addTask(temp)
                    : await ref
                        .read(allTasksProvider.notifier)
                        .updateTask(arguments!.id, temp);
                log('info', 'Change screen to MainScreen');
                FirebaseAnalytics.instance.logEvent(name: 'change_screen');
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
