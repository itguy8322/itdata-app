// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';

class ServicePlans {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> loadDataPlans() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("dataplans").get();
    Map<String, dynamic> dataPlans = {};
    List<String> networkProviders = snapshot.docs.map((doc) => doc.id).toList();
    for (String provider in networkProviders){
      dataPlans[provider] = [];
      DocumentSnapshot<Map<String, dynamic>> _snapshot =
        await db.collection("dataplans").doc(provider).get();
      dataPlans[provider].add(_snapshot.data());
    }
    //print("========== NETWORKS PLANS ==============");
    //print(dataPlans);
    //print("========== NETWORKS PLANS ==============");
    return dataPlans;
  }

  Future<List<String>> loadAirtimeTypes() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("airtimeTypes").get();
    List<String> airtimeTypes = snapshot.docs.map((doc) => doc.id).toList();
    
    //print("========== AIRTIME TYPES PLANS ==============");
    //print(airtimeTypes);
    //print("========== AIRTIME TYPES PLANS ==============");
    return airtimeTypes;
  }

  Future<Map<String, dynamic>> loadCablePlans() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("cables").get();
    Map<String, dynamic> cablePlans = {};
    List<String> cables = snapshot.docs.map((doc) => doc.id).toList();
    for (String cable in cables){
      cablePlans[cable] = [];
      DocumentSnapshot<Map<String, dynamic>> _snapshot =
        await db.collection("cables").doc(cable).get();
      cablePlans[cable].add(_snapshot.data());
    }
    //print("========== CABLE PLANS ==============");
    //print(cablePlans);
    //print("========== CABLE PLANS ==============");
    return cablePlans;
  }

  Future<List<dynamic>> loadDiscos() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection("electricity").doc("discos").get();
    Map<String, dynamic>? data = snapshot.data();
    //print(data);
    //print("DISCOS");
    final discos = data?['names'];
    //print("========== NETWORKS PLANS ==============");
    //print(discos);
    //print("========== NETWORKS PLANS ==============");
    return discos;
  }

  Future<Map<String, dynamic>> loadExamTypes() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("edupins").get();
    Map<String, dynamic> examTypes = {};
    List<String> exams = snapshot.docs.map((doc) => doc.id).toList();
    for (String examType in exams){
      
      DocumentSnapshot<Map<String, dynamic>> _snapshot =
        await db.collection("edupins").doc(examType).get();
      examTypes[examType] = _snapshot.data();
    }
    //print("========== EXAM PLANS ==============");
    //print(examTypes);
    //print("========== EXAM PLANS ==============");
    return examTypes;
  }
}