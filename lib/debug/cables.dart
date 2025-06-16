import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itdata/debug/plans.dart';

void uploadCablePlansToFirebase(FirebaseFirestore db) async {
  print("<=============== UPLOADING CABLE PLANS TO FIREBASE =================>");
  for (String cable in cableplans.keys) {
    List<Map<String, dynamic>> plans = cableplans[cable];
    Map<String,dynamic> mainPlan = {
        'plans': []
      };
  for (Map<String, dynamic> plan in plans){
    mainPlan['plans'].add(plan);
    
  }
  await db.collection("cables").doc(cable.toUpperCase()).update(mainPlan);
  print("<=============== UPLOADING DATA TO FIREBASE =================>");
  }
  
}