// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> add(String id, Map<String, dynamic> data) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection("notifications").doc(id).get();
    Map<String, dynamic>? d = snapshot.data();
    d?["notifications"].add(data);
    await update(id, d ?? {});
  }

  Future<void> update(
    String id,
    Map<String, dynamic> data,
  ) async {
    await db.collection("notification").doc(id).update(data);
  }

  Future<void> delete(
    String path,
    String user,
    Map<String, dynamic> data,
  ) async {
    db.collection(path).doc(user).delete();
    db.collection(path).doc(user).delete();
  }

  Future<List<dynamic>> load(String id) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection("notification").doc(id).get();
    final data = snapshot.data();
    print("============ NOTIFICATION DATA RECEIVED ============");
    print(data);
    print("============ NOTIFICATION DATA RECEIVED ============");
    final _data = data?['notifications'];
    return _data;
  }
}
