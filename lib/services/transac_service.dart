import 'package:cloud_firestore/cloud_firestore.dart';

class TransacService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> add(String path, String user, Map<String, dynamic> data) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection(path).doc(user).get();
    Map<String, dynamic>? d = snapshot.data();
    d?[path].add(data);
    await update(path, user, d ?? {});
  }

  Future<void> update(
    String path,
    String user,
    Map<String, dynamic> data,
  ) async {
    await db.collection(path).doc(user).update(data);
  }

  Future<void> delete(
    String path,
    String user,
    Map<String, dynamic> data,
  ) async {
    db.collection(path).doc(user).delete();
    db.collection(path).doc(user).delete();
  }

  Future<List<Map<String, dynamic>>> load(String path, String username) async {
    String user = username.split("@")[0].replaceAll(".", "-");
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection(path).doc(user).get();
    Map<String, dynamic>? data = snapshot.data();
    print(data);
    return [];
  }
}
