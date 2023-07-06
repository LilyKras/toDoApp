import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/providers/task.dart';
import 'package:to_do_list/ui/screens/main/widgets/app_bar.dart';
import 'package:to_do_list/ui/screens/main/widgets/new_task_button.dart';
import 'package:to_do_list/ui/screens/main/widgets/tasks_list.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _isInit = true;
  var _isLoading = false;
  Future<void> _refreshTasks(BuildContext context) async {
    await Provider.of<Tasks>(context, listen: false).fetchAndSetTasks();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Tasks>(context).fetchAndSetTasks().then(
            (_) => setState(() {
              _isLoading = false;
            }),
          );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const NewTaskButton(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: RefreshIndicator(
        onRefresh: () => _refreshTasks(context),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const CustomScrollView(
                slivers: [
                  TaskAppBar(),
                  TasksList(),
                ],
              ),
      ),
    );
  }
}
