
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:itdata/data/cubits/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final storage = FlutterSecureStorage();

  ThemeCubit() : super(ThemeState.defaut());

  void reset() {
    emit(ThemeState.defaut());
  }
  void loadTheme() async {
    final theme = await storage.read(key: 'theme');
    if (theme == null) {
      emit(ThemeState.defaut());
    } else if (theme == 'blue') {
      emit(ThemeState.blue());
    } else if (theme == 'orange') {
      emit(ThemeState.orange());
    } else if (theme == 'brown') {
      emit(ThemeState.brown());
    } else {
      emit(ThemeState.defaut());
    }
  }
  void setToDefaultTheme() {
    storage.write(key: 'theme', value: 'default');
    emit(ThemeState.defaut());
  }

  void setToBlueTheme() {
    storage.write(key: 'theme', value: 'blue');
    emit(ThemeState.blue());
  }

  void setToOrangeTheme(){
    storage.write(key: 'theme', value: 'orange');
    emit(ThemeState.orange());
  }

  void setToBrownTheme() {
    storage.write(key: 'theme', value: 'brown');
    emit(ThemeState.brown());
  }
}
