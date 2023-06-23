abstract interface class TaskDB{
  Future <void> save();
  Future <void> remove();
  Future <void> getAll();
}

class TaskListDB_Storage implements TaskDB{
  @override
  Future<void> save() {
    // TODO: implement save
    throw UnimplementedError();

  }
  @override
  Future<void> remove() {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<void> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}
