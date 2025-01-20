import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unity_fund/features/auth/data/services/local/storage_services.dart';
import 'package:unity_fund/injection_container.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false) {
    loadTheme();
  }
  void toggleTheme() {
    bool isDarkMode = !state;
    emit(isDarkMode);
    sl<StorageService>().setTheme(isDarkMode);
  }

  void loadTheme() {
    bool isDarkMode = sl<StorageService>().getTheme();
    emit(isDarkMode);
  }
}
