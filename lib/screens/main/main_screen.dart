import 'package:flutter/material.dart';
import 'package:to_do_list/screens/main/widgets/task_item.dart';


import '../../helpers/tasks.dart';

class MainScreen extends StatefulWidget {
  static const routeName = 'main';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _tasksDone = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Мои дела",
                      style: TextStyle(color: Colors.black, fontSize: 32, height: 38/32),
                    ),
                    IconButton(
                      padding: EdgeInsets.only(top:5),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.visibility,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              background: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Выполнено - $_tasksDone")],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [...myTasks.map((val) => TaskItem(task: val),)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        shape: const CircleBorder(),
        onPressed: () {},
        tooltip: 'Add new task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
