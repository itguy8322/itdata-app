import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/services/auth.dart';
import 'package:itdata/services/database.dart';

class LoginCubit extends Cubit<Map<String, dynamic>> {
  LoginCubit() : super({});
  void login(String email, String password) async {
    emit({"isloading": true});
    try {
      print("It's Working...");
      await Auth().authenticate(email, password);
      emit({"isloading": false, "status": "logged", "data": null});
    } on FirebaseAuthException catch (e) {
      emit({"isloading": false, "status": e.message});
    }
  }

  void signup(String email, String password, Map<String, dynamic> data) async {
    emit({"isloading": true});
    try {
      print("It's Working...");
      await Auth().create(email, password);
      await Database().addData("users", email, data);
      emit({"isloading": false, "status": "logged", "data": null});
    } on FirebaseAuthException catch (e) {
      Auth().logout();
      emit({"isloading": false, "status": e.message});
    }
  }
}
