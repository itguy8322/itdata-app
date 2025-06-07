// ignore_for_file: non_constant_identifier_names
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/models/user/user.dart';
import 'package:itdata/services/database.dart';
import 'package:itdata/data/cubits/user-data/user_state.dart';

class UserDataCubit extends Cubit<UserState> {
  UserDataCubit() : super(UserState.initial());

  void setUser(UserData user) {
    print("[SETTING USER DATA]");
    print(user.name);
    emit(state.copyWith(userData: user));
  }

  void load_user_data(String? username) async {
    try {
      emit(
        state.copyWith(
          uesrDataInProgress: true,
          userDataFailure: false,
          userDataSuccess: false,
        ),
      );
      final data = await DatabaseService().loadData("users", username!);

      emit(
        state.copyWith(
          userData: data,
          uesrDataInProgress: false,
          userDataFailure: false,
          userDataSuccess: true,
        ),
      );
    } catch (e) {
      print("ERRORRRRR: ${e.toString()}");
      emit(
        state.copyWith(
          uesrDataInProgress: false,
          userDataFailure: true,
          userDataSuccess: false,
        ),
      );
      //Navigator.pop(context);
    }
  }

  void update_data(String path, String username, UserData data) async {
    try {
      emit(
        state.copyWith(
          uesrDataInProgress: true,
          userDataFailure: false,
          userDataSuccess: false,
        ),
      );
      await DatabaseService().updateData(
        path,
        username,
        UserData.fromUserData(data),
      );
      emit(
        state.copyWith(
          userData: data,
          uesrDataInProgress: false,
          userDataFailure: false,
          userDataSuccess: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          uesrDataInProgress: false,
          userDataFailure: true,
          userDataSuccess: false,
        ),
      );
    }
  }
}
