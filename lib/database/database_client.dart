import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_workruit/database/database_schema.dart';

class DatabaseClient {
  DatabaseClient._();

  static final DatabaseClient provider = DatabaseClient._();

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
}
