import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_workruit/database/database_schema.dart';
import 'package:todo_app_workruit/model/tasks.dart';

class DatabaseClient {
  DatabaseClient._();

  static final DatabaseClient provider = DatabaseClient._();

//--------to add user
  Future<void> addUser(
      {required String uid,
      required String email,
      required String name}) async {
    try {
      FirebaseFirestore.instance
          .collection(DatabaseCollections.users)
          .doc(uid)
          .set({
        UsersSchema.name: name,
        UsersSchema.email: email,
      });
    } catch (e) {
      print(e.toString());
    }
  }

//-------------to add task
  Future<void> addTask(
      {required String uid, required String title, String? description}) async {
    try {
      FirebaseFirestore.instance
          .collection(DatabaseCollections.users)
          .doc(uid)
          .collection(DatabaseCollections.tasks)
          .doc()
          .set({
        TasksSchema.title: title,
        TasksSchema.description: description,
        TasksSchema.createdAt : DateTime.now()
      });
    } catch (e) {
      print(e.toString());
    }
  }

//-------to edit task

  Future<void> editTask(
      {required String uid,
      required String title,
      String? description,
      required String taskId}) async {
    try {
      FirebaseFirestore.instance
          .collection(DatabaseCollections.users)
          .doc(uid)
          .collection(DatabaseCollections.tasks)
          .doc(taskId)
          .update({
        TasksSchema.title: title,
        TasksSchema.description: description,
      });
    } catch (e) {
      print(e.toString());
    }
  }
//-------to fetch task

  Future<List<TaskModel>> fetchTasks({
    required String uid,
  }) async {
    try {
      var doc = await FirebaseFirestore.instance
          .collection(DatabaseCollections.users)
          .doc(uid)
          .collection(DatabaseCollections.tasks).orderBy(TasksSchema.createdAt, descending: true)
          .get();

      print(doc);

      if (doc.docs.isNotEmpty) {
        print(doc.docs.length);

        var list = doc.docs
            .map((e) => TaskModel.fromDatabase(data: e.data(), id: e.id))
            .toList();
        print(list.first.title);
        return list;
      }

      print('-------!!');
      print(uid);
      return [];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  
//-------to delete task

  Future<void> deleteTask(
      {required String uid,
      required String taskId}) async {
    try {
      FirebaseFirestore.instance
          .collection(DatabaseCollections.users)
          .doc(uid)
          .collection(DatabaseCollections.tasks)
          .doc(taskId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
