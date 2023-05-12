import 'package:todo_app_workruit/database/database_client.dart';
import 'package:todo_app_workruit/model/tasks.dart';

class UserRepository {
  //-------------adding user
  Future<void> addUser(
      {required String userId,
      required String email,
      required String name}) async {
    await DatabaseClient.provider
        .addUser(uid: userId, name: name, email: email);
  }

  //-------------adding task
  Future<void> addTask(
      {required String userId,
      required String title,
      String? description}) async {
    await DatabaseClient.provider
        .addTask(uid: userId, title: title, description: description);
  }

  //-------------fetching task
  Future<List<TaskModel>> fetchTasks({
    required String userId,
  }) async {
    return await DatabaseClient.provider.fetchTasks(
      uid: userId,
    );
  }
  //-------------editing task
  Future<void> editTask({
    required String userId,required String taskId,required String title,String? description
  }) async {
    return await DatabaseClient.provider.editTask(
      uid: userId,taskId: taskId,title: title,description: description
    );
  }
  //-------------deleting task
  Future<void> deleteTask({
    required String userId,required String taskId,
  }) async {
    return await DatabaseClient.provider.deleteTask(
      uid: userId,taskId: taskId,
    );
  }
}
