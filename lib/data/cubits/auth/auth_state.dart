import 'package:itdata/data/models/user/user.dart';

abstract class AuthState {}

class InitialState extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSucess extends AuthState {
  UserData? userInfo;
  LoginSucess({this.userInfo});
}

class LoginFailure extends AuthState {
  final String? message;
  LoginFailure({this.message});
}

class SignupLoading extends AuthState {}

class SignupSuccess extends AuthState {
  UserData? userInfo;
  SignupSuccess({this.userInfo});
}

class SignupFailure extends AuthState {
  String? message;
  SignupFailure({this.message});
}
