import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/helpers/constants.dart';

// ignore: must_be_immutable
class TimeForm extends StatefulWidget {
  TimeForm({super.key});
  bool hasDate = false;
  DateTime? selectedDate;

  @override
  State<TimeForm> createState() => _TimeFormState();
}

class _TimeFormState extends State<TimeForm> {
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
              const Text("Сделать до", style: TextStyle(color:labelLightPrimary, fontSize: 16, height: 20/16)),
              if (widget.hasDate && widget.selectedDate != null)
                Text(DateFormat.yMMMMd("ru").format(widget.selectedDate!), style: const TextStyle(color:blueLight, fontSize: 14, height: 20/14))
            ],
          ),
          Switch(
            activeColor: blueLight,
            inactiveThumbColor: backLightElevated,
            inactiveTrackColor: supportLightOverlay,
            onChanged: (bool val) async {
              if (!widget.hasDate) {
                widget.selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2123),
                    confirmText: "ГОТОВО",
                    cancelText: "ОТМЕНА",
                    locale: const Locale("ru"));
              }
              if (widget.hasDate || widget.selectedDate != null) {
                setState(() {
                  widget.hasDate = val;
                });
              }
            },
            value: widget.hasDate,
          ),
        ],
      ),
    );
  }
}
