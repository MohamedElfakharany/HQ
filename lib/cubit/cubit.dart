import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/main_screens/home_screen.dart';
import 'package:hq/screens/main_screens/profile/profile_screen.dart';
import 'package:hq/screens/main_screens/reserved/reserved_screen.dart';
import 'package:hq/screens/main_screens/results/results_screen.dart';
import 'package:hq/screens/main_screens/tests/tests_screen.dart';
import 'package:hq/shared/network/local/cache_helper.dart';
import 'package:hq/shared/network/local/const_shared.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit(): super(InitialAppStates());
  static AppCubit get(context) => BlocProvider.of(context);

  IconData loginSufIcon = Icons.visibility_off;
  bool loginIsPassword = true;

  bool? isVisitor;

  bool isEnglish = true;

  String? local = sharedLanguage;

  dynamic changeLanguage(){
    isEnglish = !isEnglish;
    local = isEnglish ? local = 'en' : local = 'ar';
    CacheHelper.saveData(key: 'local', value: local);
    sharedLanguage = local;
    if (kDebugMode) {
      print('sharedLanguage $sharedLanguage');
      print('local $local');
    }
  }
  void loginChangePasswordVisibility() {
    loginIsPassword = !loginIsPassword;
    loginSufIcon =
    loginIsPassword ? Icons.visibility : Icons.visibility_off;
    emit(AppLoginChangePasswordVisibilityState());
  }

  IconData signUpSufIcon = Icons.visibility_off;
  bool signUpIsPassword = true;

  void signUpChangePasswordVisibility() {
    signUpIsPassword = !signUpIsPassword;
    signUpSufIcon =
    signUpIsPassword ? Icons.visibility : Icons.visibility_off;
    emit(AppSignUpChangePasswordVisibilityState());
  }

  IconData resetSufIcon = Icons.visibility_off;
  bool resetIsPassword = true;

  void resetChangePasswordVisibility() {
    resetIsPassword = !resetIsPassword;
    resetSufIcon =
    resetIsPassword ? Icons.visibility : Icons.visibility_off;
    emit(AppResetChangePasswordVisibilityState());
  }

  IconData resetConfirmSufIcon = Icons.visibility_off;
  bool resetConfirmIsPassword = true;

  void resetConfirmChangePasswordVisibility() {
    resetConfirmIsPassword = !resetConfirmIsPassword;
    resetConfirmSufIcon =
    resetConfirmIsPassword ? Icons.visibility : Icons.visibility_off;
    emit(AppResetConfirmChangePasswordVisibilityState());
  }

  IconData idNumberSufIcon = Icons.visibility;
  bool idNumberIsPassword = true;

  void idNumberChangeVisibility() {
    idNumberIsPassword = !idNumberIsPassword;
    idNumberSufIcon =
    idNumberIsPassword ? Icons.visibility : Icons.visibility_off;
    emit(AppIdNumberVisibilityState());
  }

  int currentIndex = 0;

  int tapIndex = 0;

  bool fromHome = false;

  List<Widget> bottomScreens = [
    const HomeScreen(),
    const TestsScreen(),
    const ReservedScreen(),
    const ResultsScreen(),
    const ProfileScreen(),
  ];

  Future<void> changeBottomScreen(int index) async {
    if (index == 1){
      if (fromHome){
        currentIndex = index;
        tapIndex = 1;
      } else {
        currentIndex = index;
        tapIndex = 0;
      }
    }else {
      fromHome = false;
      currentIndex = index;
    }
    emit(AppChangeBottomNavState());
  }

  int currentCarouselIndex = 0;

  void changeCarouselState(int newIndex) {
    currentCarouselIndex = newIndex;
    emit(AppChangeCarouselState());
  }
}