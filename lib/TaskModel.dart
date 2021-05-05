import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = "todo";
final String Column_id = "id";
final String Column_belanja = "belanja";

class TaskModel {
  final String belanja;
  int id;

  TaskModel({this.belanja, this.id});
  Map<String, dynamic> toMap() {
    return {Column_belanja: this.belanja};
  }
}

class TodoHelper {
  Database db;

  TodoHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    db = await openDatabase(join(await getDatabasesPath(), "indri.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tableName($Column_id INTERGER PRIMARY KEY AUTO INCREMENT , $Column_belanja TEXT)");
    }, version: 1);
  }

  Future<void> insertTask(TaskModel task) async {
    try {
      db.insert(tableName, task.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (_) {
      print(_);
    }
  }

  Future<List<TaskModel>> getAllTask() async {
    final List<Map<String, dynamic>> tasks = await db.query(tableName);

    List.generate(tasks.length, (i) {
      return TaskModel(
          belanja: tasks[i][Column_belanja], id: tasks[i][Column_id]);
    });
  }
}
