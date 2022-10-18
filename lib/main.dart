import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/screens/intro_screens/startup/splash_screen.dart';
import 'package:hq/shared/bloc_observer.dart';
import 'package:hq/shared/network/local/cache_helper.dart';
import 'package:hq/shared/network/remote/dio_helper.dart';
import 'package:hq/translations/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  DioHelper.init();

  // token = CacheHelper.getData(key: 'token');
  // verified = CacheHelper.getData(key: 'verified');
  // if(sharedLanguage != null) {
  //   sharedLanguage = CacheHelper.getData(key: "local");
  // }else{
  //   sharedLanguage = 'en';
  // }
  BlocOverrides.runZoned(
    () {
      runApp(
        EasyLocalization(
          path: 'assets/translations',
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          fallbackLocale: const Locale('en'),
          assetLoader: const CodegenLoader(),
          child: const MyApp(
            startWidget: SplashScreen(),
          ),
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({
    super.key,
    required this.startWidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates +
            [
              CountryLocalizations.delegate,
            ],
        home: startWidget,
      ),
    );
  }
}
