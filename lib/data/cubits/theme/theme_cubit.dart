
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  //final storage = FlutterSecureStorage();

  ThemeCubit() : super(ThemeState.defaut());

  void setToDefaultTheme() {
    emit(ThemeState.defaut());
  }

  void setToBlueTheme() {
    emit(ThemeState.blue());
  }

  void setToOrangeTheme() => emit(ThemeState.orange());

  void setToBrownTheme() => emit(ThemeState.brown());
}
