// ignore_for_file: non_constant_identifier_names
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/services/database.dart';

class UserDataCubit extends Cubit<Map<String, dynamic>> {
  UserDataCubit() : super({});
  void set_user_id(String username) {
    emit({"username": username});
  }

  void load_user_data(String? username) async {
    try {
      final snapshot = await Database().loadData("users", username!);
      Map<String, dynamic> data = Map<String, dynamic>.from(
        snapshot.value as Map,
      );
      emit(data);
    } catch (e) {
      print("ERRORRRRR: ${e.toString()}");
      //Navigator.pop(context);
    }
  }

  void update_data(
    String path,
    String username,
    Map<String, dynamic> data,
  ) async {
    emit({"isloading": true});
    try {
      await Database().updateData(path, username, data);
      emit({"isloading": false});
    } catch (e) {
      emit({"isloading": false});
    }
  }
}
