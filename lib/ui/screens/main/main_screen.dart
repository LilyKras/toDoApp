import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:to_do_list/providers/counter.dart';

import 'package:to_do_list/ui/screens/main/widgets/app_bar.dart';
import 'package:to_do_list/ui/screens/main/widgets/new_task_button.dart';
import 'package:to_do_list/ui/screens/main/widgets/tasks_list.dart';

import '../../../models/task.dart';
import '../../../providers/tasks.dart';

class MainScreen extends ConsumerStatefulWidget {
  static const routeName = '/main';
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  var _isInit = true;
  var _isLoading = false;
  Future<void> _refreshTasks(BuildContext context, WidgetRef ref) async {
    await ref.read(allTasksProvider.notifier).fetchAndSetTasks();
    List<Task> temp = ref.watch(allTasksProvider) as List<Task>;
    ref.read(counterProvider.notifier).fetchAndSetCounter(temp);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      _refreshTasks(context, ref).then(
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
        onRefresh: () => _refreshTasks(context, ref),
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
