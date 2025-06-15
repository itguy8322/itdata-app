// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';

class NetworkProvidersService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> add(String id, Map<String, dynamic> data) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection("transactions").doc(id).get();
    Map<String, dynamic>? d = snapshot.data();
    d?["transactions"].add(data);
    await update(id, d ?? {});
  }

  Future<void> update(
    String id,
    Map<String, dynamic> data,
  ) async {
    await db.collection("transactions").doc(id).update(data);
  }

  Future<void> delete(
    String path,
    String user,
    Map<String, dynamic> data,
  ) async {
    db.collection(path).doc(user).delete();
    db.collection(path).doc(user).delete();
  }

  Future<List<String>> loadNetworkProviders() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("networks").get();
    List<String> networkProviders = snapshot.docs.map((doc) => doc.id).toList();
    print("========== NETWORKS PROVIDERS ==============");
    print("LENGTH: ${snapshot.docs.length}");
    print(networkProviders);
    print("========== NETWORKS PROVIDERS ==============");
    return networkProviders;
  }
}
