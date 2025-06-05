import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeCubit extends Cubit<Map<String, dynamic>> {
  final storage = FlutterSecureStorage();

  ThemeCubit()
    : super({
        "mainColor": Color.fromRGBO(82, 101, 140, 1),
        "subcolor": Colors.white,
      });

  void setColor(Color color) {}
  void mainColor() {}
  void subColor() {}
}
