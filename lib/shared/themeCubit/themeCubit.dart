import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'package:shop_app/shared/themeCubit/themeStates.dart';

class ChangeModeCubit extends Cubit<ThemeStates> {
  ChangeModeCubit() : super(ThemeInitialState());

  static ChangeModeCubit get(context) => BlocProvider.of(context);
  bool isDark = false;

  void changeThemeMode({bool? fromCache}) {
    if (fromCache != null)
      isDark = fromCache;
    else
      isDark = !isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
      emit(ThemeChangeThemeModeState());
    });
  }
}
