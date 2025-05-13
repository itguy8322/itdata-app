// ignore_for_file: non_constant_identifier_names
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/services/database.dart';
import 'package:itdata/states/user_states.dart';

class UserDataCubit extends Cubit<UserStates> {
  UserDataCubit() : super(UserInitial());

  void load_user_data(String? username) async {
    try {
      final data = await Database().loadData("users", username!);

      emit(UserLoaded(data));
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
    emit(UserLoading());
    try {
      await Database().updateData(path, username, data);
      emit(UserLoaded(data));
    } catch (e) {
      emit(UserError("Error updating user data"));
    }
  }
}
