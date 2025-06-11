import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itdata/data/models/user/user.dart';

class DatabaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addUser(
    String path,
    String id,
    Map<String, dynamic> data,
  ) async {
    await db.collection(path).doc(id).set(data);
    await db.collection("transactions").doc(id).set({"transaction": []});
    await db.collection("notification").doc(id).set({"notifications": []});
  }

  Future<UserData> updateData(
    String path,
    String id,
    Map<String, dynamic> data,
  ) async {
    await db.collection(path).doc(id).update(data);
    final data0 = await loadData(path, id);
    return data0;
  }

  Future<void> removeData(
    String path,
    String id,
    Map<String, dynamic> data,
  ) async {
    db.collection(path).doc(id).delete();
    db.collection("transactions").doc(id).delete();
    db.collection("notifications").doc(id).delete();
  }

  Future<UserData> loadData(String path, String id) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection(path).doc(id).get();
    Map<String, dynamic>? data = snapshot.data();
    return UserData.fromJson(data!);
  }

  //<=================== add, update, delete data ====================>
}
