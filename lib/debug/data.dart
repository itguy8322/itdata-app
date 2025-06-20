
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itdata/debug/plans.dart';

void loadDataPlansToFirebase(FirebaseFirestore db){
  //print("<=============== UPLOADING DATA TO FIREBASE =================>");
  
  for (String network in dataplans.keys){
    List<Map<String, dynamic>> plans = dataplans[network];
    Map<String,dynamic> mainPlan = {
        'network_id': network == "MTN_PLAN" ? "1" : 
                      network == "GLO_PLAN" ? "2" : 
                      network == "AIRTEL_PLAN" ? "4" : 
                      network == "9MOBILE_PLAN" ? "3" : "",
        'plans': {}
      };
      network = network.replaceAll("_PLAN", "").toUpperCase();
      for (Map<String, dynamic> plan in plans){
        Map<dynamic, dynamic> plans = mainPlan['plans'];
        final plan_type = plan['plan_type'];
        if (!plans.containsKey(plan_type)){
          plans[plan_type] = [];
        }
        
        final _plan = {
          "plan_id": plan["dataplan_id"],
          "provider": plan["plan_network"],
          "validate": "${plan['plan']} ${plan['month_validate']}",
          "cost": plan['plan_amount'],
          "price": "100"
        };
        plans[plan_type].add(_plan);
      }  
    db.collection("networks").doc(network.toUpperCase()).set(mainPlan);
  }
  //print("<=============== UPLOADING DATA TO FIREBASE =================>");
}