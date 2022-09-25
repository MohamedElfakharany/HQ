import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hq/screens/intro_screens/auth/login_screen.dart';
import 'package:hq/screens/intro_screens/startup/select_lang_screen.dart';
import 'package:hq/screens/main_screens/home_layout_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Widget widget;
    if (kDebugMode) {
      printWrapped('from main the token is $token');
      printWrapped('from main the verified is $verified');
      printWrapped('from main the sharedLanguage is $sharedLanguage');
    }

    if (token != null) {
      if (verified == true) {
        widget = const HomeLayoutScreen();
      } else {
        widget = const LoginScreen();
      }
    } else {
      widget = const SelectLangScreen();
    }

    super.initState();
    Timer(
      const Duration(milliseconds: 2000),
          () {
        navigateAndFinish(context, widget);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 150, height: 150,),
            verticalLargeSpace,
            verticalLargeSpace,
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
