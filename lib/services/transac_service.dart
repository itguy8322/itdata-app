import 'package:cloud_firestore/cloud_firestore.dart';

class TransacService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addTransaction(
    String path,
    String username,
    Map<String, dynamic> data,
  ) async {
    String user = username.split("@")[0].replaceAll(".", "-");
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection(path).doc(user).get();
    Map<String, dynamic>? d = snapshot.data();
    d?["transaction"].add(data);
    await updateTransaction(path, username, d ?? {});
  }

  Future<void> updateTransaction(
    String path,
    String username,
    Map<String, dynamic> data,
  ) async {
    String user = username.split("@")[0].replaceAll(".", "-");

    await db.collection(path).doc(user).update(data);
  }

  Future<void> deleteTransaction(
    String path,
    String username,
    Map<String, dynamic> data,
  ) async {
    String user = username.split("@")[0].replaceAll(".", "-");
    db.collection(path).doc(user).delete();
    db.collection("transactions").doc(user).delete();
  }

  Future<Map<String, dynamic>> loadtransactions(
    String path,
    String username,
  ) async {
    String user = username.split("@")[0].replaceAll(".", "-");
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection(path).doc(user).get();
    Map<String, dynamic>? data = snapshot.data();
    print(data);
    return data ?? {};
  }
}
