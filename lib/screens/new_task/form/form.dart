import 'package:flutter/material.dart';
import 'package:to_do_list/helpers/constants.dart';
import 'package:to_do_list/screens/new_task/form/priority_form.dart';
import 'package:to_do_list/screens/new_task/form/time_form.dart';

class TaskForm extends StatelessWidget {
  const TaskForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: const TextStyle(color: labelLightPrimary, fontSize: 16, height: 20/16),
                minLines: 3,
                maxLines: 25,
                decoration: const InputDecoration(
                    hintText: "Что надо сделать…", border: InputBorder.none, hintStyle: TextStyle(color: labelLightTertiary, fontSize: 16, height: 20/16)),
              ),
            ),
          ),
        ),
        PriorityForm(),
        const Divider(color:supportLightSeparator),
        TimeForm(),
        const Divider(color:supportLightSeparator),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              const Icon(
                Icons.delete,
                color: redLight,
              ),
              TextButton(onPressed: () {}, child: const Text("Удалить",style: TextStyle(color: redLight,fontSize: 16, height: 20/16),))
            ],
          ),
        )
      ],
    );
  }
}
