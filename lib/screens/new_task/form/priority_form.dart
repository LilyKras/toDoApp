import 'package:flutter/material.dart';
import 'package:to_do_list/helpers/constants.dart';

const List<String> list = <String>['Нет', 'Низкий', '‼ Высокий'];

// ignore: must_be_immutable
class PriorityForm extends StatefulWidget {
  PriorityForm({super.key});
  String dropdownValue = list.first;

  @override
  State<PriorityForm> createState() => _PriorityFormState();
}

class _PriorityFormState extends State<PriorityForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Важность", style: TextStyle(color:labelLightPrimary, fontSize: 16, height: 20/16),),
          DropdownButton<String>(
            value: widget.dropdownValue,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                widget.dropdownValue = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: value == '‼ Высокий'? Text(value, style: const TextStyle(color: redLight, fontSize: 14, height: 20/14),) : Text(value, style: const TextStyle(fontSize: 14, height: 20/14)),
              );
            }).toList(),
            underline: Container(),
          )
        ],
      ),
    );
  }
}
