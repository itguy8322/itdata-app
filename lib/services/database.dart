import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itdata/data/models/user/user.dart';

class DatabaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addUser(
    String path,
    String username,
    Map<String, dynamic> data,
  ) async {
    String user = username;
    await db.collection(path).doc(user).set(data);
    await db.collection("transactions").doc(user).set({"transaction": []});
    await db.collection("notification").doc(user).set({"notifications": []});
  }

  Future<UserData> updateData(
    String path,
    String username,
    Map<String, dynamic> data,
  ) async {
    String user = username;
    await db.collection(path).doc(user).update(data);
    final _data = await loadData(path, username);
    return _data;
  }

  Future<void> removeData(
    String path,
    String username,
    Map<String, dynamic> data,
  ) async {
    String user = username;
    db.collection(path).doc(user).delete();
    db.collection("transactions").doc(user).delete();
    db.collection("notifications").doc(user).delete();
  }

  Future<UserData> loadData(String path, String username) async {
    String user = username;
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection(path).doc(user).get();
    Map<String, dynamic>? data = snapshot.data();
    return UserData.fromJson(data!);
  }

  //<=================== add, update, delete data ====================>
}
