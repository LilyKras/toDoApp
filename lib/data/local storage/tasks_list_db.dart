import '../../models/task.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

import '../../providers/task.dart';
import '../api/api.dart';

Future<Database> _getDataBase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = sql.openDatabase(
    path.join(dbPath, 'tasks.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE my_tasks (id TEXT, text TEXT, importance TEXT, deadline INTEGER, done INTEGER, created_at INTEGER, changed_at INTEGER, last_updated_by TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

abstract interface class TaskDB {
  Future<void> addItem(Task task);
  Future<void> removeItem(String id);
  Future<void> updateItem(String id, Task newTask);
  Future<List> getAll();
  Future<void> patch(List<Task> tasks);
}

class TaskListDBStorage implements TaskDB {
  @override
  Future<void> addItem(Task task) async {
    final db = await _getDataBase();
    db.insert('my_tasks', {
      'id': task.id,
      'text': task.text,
      'importance': getPriority(task.priority),
      'deadline':
          task.hasDate == false ? -1 : task.date!.millisecondsSinceEpoch,
      'done': (task.doneStatus) == true ? 1 : 0,
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'changed_at': DateTime.now().millisecondsSinceEpoch,
      'last_updated_by': 'undefined',
    });
  }

  @override
  Future<void> removeItem(String id) async {
    final db = await _getDataBase();
    await db.rawDelete('DELETE FROM my_tasks WHERE id = ?', [id]);
  }

  @override
  Future<void> updateItem(String id, Task newTask) async {
    final db = await _getDataBase();
    await db.rawUpdate(
      'UPDATE my_tasks SET text = ?, importance = ?, deadline = ?, done = ?, changed_at = ?, last_updated_by = ? WHERE id = ?',
      [
        newTask.text,
        getPriority(newTask.priority),
        newTask.hasDate ? newTask.date!.millisecondsSinceEpoch : -1,
        newTask.doneStatus == false ? 0 : 1,
        DateTime.now().millisecondsSinceEpoch,
        'unknown',
        id
      ],
    );
  }

  @override
  Future<List<Task>> getAll() async {
    final db = await _getDataBase();
    final data = await db.query('my_tasks');
    final tasks = data.map(
      (row) => Task(
        id: row['id'] as String,
        text: row['text'] as String,
        priority: importanceToPriority(row['importance'] as String),
        hasDate: row['deadline'] as int == -1 ? false : true,
        doneStatus: row['done'] == 1 ? true : false,
        date: row['deadline'] as int == -1
            ? null
            : DateTime.fromMillisecondsSinceEpoch(row['deadline'] as int),
      ),
    );
    return tasks.toList();
  }
  

  @override
  Future<void> patch(List<Task> tasks) async {
    List<Task> dbTasks = await getAll();
    Map <String, Task> helper = {};
    for (var elem in tasks){
      helper[elem.id] = elem;
    }
    for (var elem in dbTasks){
      if (helper.containsKey(elem.id)){
        updateItem(elem.id, helper[elem.id]!);
      }
      else{
        removeItem(elem.id);
      }
      helper.remove(elem.id);
    }
    for (var elem in helper.keys){
      addItem(helper[elem]!);
    }
  }
}
