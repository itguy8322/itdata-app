// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageCubit extends Cubit<Map<String, dynamic>> {
  final storage = FlutterSecureStorage();
  StorageCubit() : super({"remember_me": false});

  void set_remember_me(String username, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      await storage.write(key: "username", value: username);
      await storage.write(key: "password", value: password);
      await storage.write(
        key: "remember_me",
        value: !state["remember_me"] ? "true" : "false",
      );
      emit({
        "username": username,
        "password": password,
        "remember_me": !state["remember_me"],
      });
      //print("REMEBER ME IS SET TO ${state["remember_me"]}");
    } else {
      emit({"remember_me": state["remember_me"], "username": "", "password": ""});

    }
  }

  void load_storage() async {
    Map<String, dynamic> newData = Map<String, dynamic>.from(state);
    try {
      String? username = await storage.read(key: "username");
      String? password = await storage.read(key: "password");
      String? remember_me = await storage.read(key: "remember_me");
      newData["username"] = username;
      newData["password"] = password;
      if (remember_me == "true") {
        newData["remember_me"] = true;
      } else {
        newData["remember_me"] = false;
      }
      emit(newData);
    } catch (e) {
      emit({"remember_me": false});
    }
  }
}
