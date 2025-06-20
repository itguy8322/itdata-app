// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itdata/debug/data.dart';
// import 'package:itdata/debug/electric.dart';
// import 'package:itdata/debug/plans.dart';
void uploadToFirebase() async {
  //print("<=============== UPLOADING DATA TO FIREBASE =================>");
  final FirebaseFirestore db = FirebaseFirestore.instance;
  loadDataPlansToFirebase(db);
  // loadDiscosToFirebase(db);
  //print("<=============== UPLOADING DATA TO FIREBASE =================>");
}