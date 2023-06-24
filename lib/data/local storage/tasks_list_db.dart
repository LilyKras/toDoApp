import '../../models/task.dart';

abstract interface class TaskDB {
  Future<void> addItem(Task task);
  Future<void> removeItem(String id);
  Future<void> updateItem(String id, Task newTask);
  Future<List> getAll();
}

// class TaskListDBStorage implements TaskDB{
//   @override
//   Future<void> addItem() {
//     // TODO: implement save
//     throw UnimplementedError();

//   }
//   @override
//   Future<void> removeItem() {
//     // TODO: implement remove
//     throw UnimplementedError();
//   }
//   @override
//   Future<void> updateItem() {
//     // TODO: implement updateItem
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> getAll() {
//     // TODO: implement getAll
//     throw UnimplementedError();
//   }
// }
