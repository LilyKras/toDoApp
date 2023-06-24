import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../../../helpers/logger.dart';
import '../../../../models/task.dart';

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
  bool hasDate = false;
  DateTime? selectedDate;

  @override
  void didChangeDependencies() {
    hasDate = widget.arguments == null ? false : widget.arguments!.hasDate;
    selectedDate = widget.arguments == null ? null : widget.arguments!.date;
    widget.hasDate =
        widget.arguments == null ? false : widget.arguments!.hasDate;
    widget.selectedDate =
        widget.arguments == null ? null : widget.arguments!.date;
    log(
      'info',
      'Initial value hasDate is $hasDate, Initial value date is $selectedDate',
    );
    super.didChangeDependencies();
  }

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
              Text(
                AppLocalizations.of(context)!.makeTo,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 16,
                  height: 20 / 16,
                ),
              ),
              if (hasDate && selectedDate != null)
                Text(
                  DateFormat('d MMMM y', AppLocalizations.of(context)!.locale).format(selectedDate!),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    height: 20 / 14,
                  ),
                )
            ],
          ),
          Switch(
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveThumbColor: Theme.of(context).colorScheme.inversePrimary,
            inactiveTrackColor: Theme.of(context).shadowColor,
            onChanged: (bool val) async {
              if (!hasDate) {
                log('info', 'Open showDatePicker');
                selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2123),
                  confirmText: AppLocalizations.of(context)!.ok,
                  cancelText: AppLocalizations.of(context)!.cancel,
                );
              }
              if (hasDate || selectedDate != null) {
                setState(() {
                  hasDate = val;
                });
              }
              if (selectedDate == null) {
                log('warning', 'No date selected');
              }
              widget.hasDate = hasDate;
              widget.selectedDate = selectedDate;
              log('info', 'New date = $selectedDate');
            },
            value: hasDate,
          ),
        ],
      ),
    );
  }
}
