import 'package:cloud_firestore/cloud_firestore.dart';

void loadDiscosToFirebase(FirebaseFirestore db) {
  print("<=============== UPLOADING DISCO DATA TO FIREBASE =================>");
  Map<String, dynamic> _discos = {
    "names": [
      "Ikeja Electric",
      "Eko Electric",
      "Abuja Electric",
      "Kano Electric",
      "Enugu Electric",
      "Port Harcourt Electric",
      "Ibadan Electric",
      "Kaduna Electric",
      "Jos Electric",
      "Benin Electric",
      "Yola Electric",
      "Aba Electric"
    ],
  };
  
  db.collection("electricity").doc("discos").set(_discos);
  
  print("<=============== UPLOADING DISCO DATA TO FIREBASE =================>");
}