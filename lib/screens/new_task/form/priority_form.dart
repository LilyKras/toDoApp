import 'package:flutter/material.dart';
import 'package:to_do_list/helpers/enums.dart';

import '../../../models/task.dart';

const List<String> list = <String>['Нет', 'Низкий', '‼ Высокий'];

String priorityToString(Priority priority) {
  if (priority == Priority.hight) {
    return '‼ Высокий';
  }
  if (priority == Priority.low) {
    return 'Низкий';
  }
  return 'Нет';
}

// ignore: must_be_immutable
class PriorityForm extends StatefulWidget {
  PriorityForm({super.key, required this.arguments});
  Task? arguments;
  String priority = list.first;

  @override
  State<PriorityForm> createState() => _PriorityFormState();
}

class _PriorityFormState extends State<PriorityForm> {
  String priority = list.first;

  @override
  void didChangeDependencies() {
    priority = widget.arguments == null
        ? list.first
        : priorityToString(widget.arguments!.priority);

    widget.priority = widget.arguments == null
        ? list.first
        : priorityToString(widget.arguments!.priority);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Важность",
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 16,
                height: 20 / 16),
          ),
          DropdownButtonFormField<String>(
            dropdownColor: Theme.of(context).cardTheme.color,
            onSaved: (newValue) => widget.priority = priority,
            decoration: InputDecoration(
                border: InputBorder.none,
                errorStyle: TextStyle(color: Theme.of(context).errorColor)),
            value: priority,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                priority = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: value == '‼ Высокий'
                    ? Text(
                        value,
                        style: TextStyle(
                            color: Theme.of(context).errorColor,
                            fontSize: 14,
                            height: 20 / 14),
                      )
                    : Text(
                        value,
                        style: TextStyle(
                            fontSize: 14,
                            height: 20 / 14,
                            color:
                                Theme.of(context).textTheme.bodyLarge!.color),
                      ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
