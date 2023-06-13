import 'package:flutter/material.dart';

import '../../../models/task.dart';

// ignore: must_be_immutable
class TextForm extends StatelessWidget {
  TextForm({super.key, required this.arguments});
  String text = "";
  Task? arguments;

  @override
  Widget build(BuildContext context) {
    text = arguments == null ? "" : arguments!.text;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: text,
            onSaved: (newValue) => text = newValue!,
            validator: (value) {
              if (value == null || value == "") {
                return "Вы не ввели задачу";
              }
              return null;
            },
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 16,
                height: 20 / 16),
            minLines: 3,
            maxLines: 25,
            decoration: InputDecoration(
                hintText: "Что надо сделать…",
                border: InputBorder.none,
                hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall!.color,
                    fontSize: 16,
                    height: 20 / 16)),
          ),
        ),
      ),
    );
  }
}
