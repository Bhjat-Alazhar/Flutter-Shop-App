import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'modules/login_screen.dart';
import 'package:shop_app/modules/on_boarding.dart';
import 'package:shop_app/shared/blocObsever.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/api_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'package:shop_app/shared/themeCubit/themeCubit.dart';
import 'package:shop_app/shared/themeCubit/themeStates.dart';
import 'layout/shopCubit/shopCubit.dart';
import 'layout/shop_layout.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51LLP1yIDZh9whSkkMvbey9Fc5eIfpSbKTNFFI0Fd7SdDYHZvgGCAWGmVjs0IXRxGHsU9DN1oAw0WONsv2iC9TWEP00JNvGUnDS';
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print('token is : $token');
  if (onBoarding != null) {
    if (token != null)
      widget = ShopAppLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  print('onBoarding state is : $onBoarding');
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;
  MyApp({this.isDark, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              ChangeModeCubit()..changeThemeMode(fromCache: isDark),
        ),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getProfileData()
              ..getFavoritesData()),
      ],
      child: BlocConsumer<ChangeModeCubit, ThemeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ChangeModeCubit.get(context).isDark
                ? ThemeMode.light
                : ThemeMode.dark,
            home: Directionality(
              child: startWidget,
              textDirection: TextDirection.ltr,
            ),
          );
        },
      ),
    );
  }
}
