import '../models/task.dart';

abstract interface class TaskDB {
  Future<void> addItem(Task task);
  Future<void> removeItem(String id);
  Future<void> updateItem(String id, Task newTask);
  Future<List> getAll();
  Future<void> patch(List<Task> tasks);
}
