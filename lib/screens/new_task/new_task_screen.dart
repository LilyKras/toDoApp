import 'package:flutter/material.dart';
import 'package:to_do_list/helpers/constants.dart';
import 'package:to_do_list/screens/main/main_screen.dart';
import 'package:to_do_list/screens/new_task/form/form.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});
  static const routeName = 'new_task';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backLightPrimary,
      body: const TaskForm(),
      appBar: AppBar(
        backgroundColor: backLightPrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {Navigator.of(context).pushReplacementNamed(MainScreen.routeName);},
              icon: const Icon(Icons.close, color: labelLightPrimary,),
            ),
            TextButton(
              onPressed: () {Navigator.of(context).pushReplacementNamed(MainScreen.routeName);},
              child: Text("Сохранить".toUpperCase(), style: const TextStyle(fontSize: 14, height: 24/14, color:blueLight),),
            ),
          ],
        ),
      ),
    );
  }
}
