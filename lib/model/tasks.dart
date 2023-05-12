import 'package:todo_app_workruit/database/database_schema.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;

  const TaskModel(
      {required this.id, required this.description, required this.title});

  factory TaskModel.fromDatabase({
    required Map<String, dynamic> data,
    required String id,
  }) {
    return TaskModel(
      id: id,
      description: data[TasksSchema.description],
      title: data[TasksSchema.title],
    );
  }
}
