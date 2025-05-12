import 'package:firebase_database/firebase_database.dart';

class Database {
  final FirebaseDatabase db = FirebaseDatabase.instance;

  Future<void> addData(
    String path,
    String username,
    Map<String, dynamic> data,
  ) async {
    String user = username.split("@")[0].replaceAll(".", "-");
    DatabaseReference ref = db.ref().child(path);
    await ref.set({user: {}});
    DatabaseReference ref1 = db.ref().child(path).child(user);
    await ref1.set(data);
  }

  Future<void> updateData(
    String path,
    String username,
    Map<String, dynamic> data,
  ) async {
    DatabaseReference ref = db.ref().child(path).child(username);
    await ref.update(data);
  }

  Future<void> removeData(
    String path,
    String username,
    Map<String, dynamic> data,
  ) async {
    DatabaseReference ref = db.ref().child(username);
    await ref.remove();
  }

  Future<DataSnapshot> loadData(String path, String username) async {
    String user = username.split("@")[0].replaceAll(".", "-");
    DatabaseReference ref = db.ref().child(path).child(user);
    Future<DataSnapshot> data = ref.get();
    return data;
  }
}
