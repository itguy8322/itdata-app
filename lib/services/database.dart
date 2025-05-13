import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addData(
    String path,
    String username,
    Map<String, dynamic> data,
  ) async {
    String user = username.split("@")[0].replaceAll(".", "-");
    await db.collection(path).doc(user).set(data);
    await db.collection("transactions").doc(user).set({"transaction": []});
  }

  Future<void> updateData(
    String path,
    String username,
    Map<String, dynamic> data,
  ) async {
    String user = username.split("@")[0].replaceAll(".", "-");
    await db.collection(path).doc(user).update(data);
  }

  Future<void> removeData(
    String path,
    String username,
    Map<String, dynamic> data,
  ) async {
    String user = username.split("@")[0].replaceAll(".", "-");
    db.collection(path).doc(user).delete();
    db.collection("transactions").doc(user).delete();
  }

  Future<Map<String, dynamic>> loadData(String path, String username) async {
    String user = username.split("@")[0].replaceAll(".", "-");
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection(path).doc(user).get();
    Map<String, dynamic>? data = snapshot.data();
    return data ?? {};
  }
}
