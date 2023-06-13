import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/task.dart';

// ignore: must_be_immutable
class TimeForm extends StatefulWidget {
  TimeForm({super.key, this.arguments});
  bool hasDate = false;
  DateTime? selectedDate;
  Task? arguments;

  @override
  State<TimeForm> createState() => _TimeFormState();
}

class _TimeFormState extends State<TimeForm> {
  bool hasDate = false ;
  DateTime? selectedDate;
  @override

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Сделать до",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 16,
                      height: 20 / 16)),
              if (hasDate && selectedDate != null)
                Text(DateFormat.yMMMMd("ru").format(selectedDate!),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14,
                        height: 20 / 14))
            ],
          ),
          Switch(
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveThumbColor: Theme.of(context).colorScheme.inversePrimary,
            inactiveTrackColor: Theme.of(context).shadowColor,
            onChanged: (bool val) async {
              if (!hasDate) {
                selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2123),
                    confirmText: "ГОТОВО",
                    cancelText: "ОТМЕНА",
                    locale: const Locale("ru"));
              }
              if (hasDate || selectedDate != null) {
                setState(() {
                  hasDate = val;
                });
              }
              widget.hasDate = hasDate;
              widget.selectedDate = selectedDate;
              debugPrint(hasDate.toString());
            },
            value: hasDate,
          ),
        ],
      ),
    );
  }
}
