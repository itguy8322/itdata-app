import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/auth/auth_state.dart';
import 'package:itdata/data/models/user/user.dart';
import 'package:itdata/services/auth.dart';
import 'package:itdata/services/database.dart';

class AuthCubit extends Cubit<AuthState> {
  final Auth _auth;
  final DatabaseService _databaseService;
  AuthCubit(this._auth, this._databaseService) : super(InitialState());
  void setInitial() {
    emit(InitialState());
  }

  void login(String email, String password) async {
    emit(LoginLoading());
    try {
      print("It's Working...");
      await Auth().authenticate(email, password);
      String id = email.split("@")[0];
      UserData user = await DatabaseService().loadData("users", id);
      emit(LoginSucess(userInfo: user));
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(message: "Error: ${e.message}"));
    }
  }

  void signup(String email, String password, Map<String, dynamic> data) async {
    emit(SignupLoading());
    try {
      print("It's Working...");
      await _auth.create(email, password);
      await _databaseService.addUser("users", email, data);
      String id = data["id"];
      UserData user = await DatabaseService().loadData("users", id);
      emit(SignupSuccess(userInfo: user));
    } on FirebaseAuthException catch (e) {
      Auth().logout();
      emit(SignupFailure(message: "Error: ${e.message}"));
    }
  }

  void logout() {}
}
