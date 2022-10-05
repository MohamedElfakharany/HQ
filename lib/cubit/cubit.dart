import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/models/auth_models/create_token_model.dart';
import 'package:hq/models/auth_models/reset_password_model.dart';
import 'package:hq/models/cores_model/branch_model.dart';
import 'package:hq/models/cores_model/carousel_model.dart';
import 'package:hq/models/cores_model/city_model.dart';
import 'package:hq/models/cores_model/country_model.dart';
import 'package:hq/models/cores_model/relations_model.dart';
import 'package:hq/models/auth_models/verify_model.dart';
import 'package:hq/models/auth_models/user_resource_model.dart';
import 'package:hq/models/model_test.dart';
import 'package:hq/screens/intro_screens/startup/onboarding_screen.dart';
import 'package:hq/screens/main_screens/home_screen.dart';
import 'package:hq/screens/main_screens/profile/profile_screen.dart';
import 'package:hq/screens/main_screens/reserved/reserved_screen.dart';
import 'package:hq/screens/main_screens/results/results_screen.dart';
import 'package:hq/screens/main_screens/tests/tests_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/network/local/cache_helper.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/shared/network/remote/end_points.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppStates());

  static AppCubit get(context) => BlocProvider.of(context);

  UserResourceModel? userResourceModel;
  CountryModel? countryModel;
  CityModel? cityModel;
  BranchModel? branchModel;
  VerifyModel? verifyModel;
  CarouselModel? carouselModel;
  RelationsModel? relationsModel;
  CreateTokenModel? createTokenModel;
  ResetPasswordModel? resetPasswordModel;
  TestsModel? testsModel;

  List<BranchesDataModel>? branchNames = [];
  List<String> branchName = [];

  List<RelationsDataModel>? relationsNames = [];
  List<String> relationsName = [];

  Future register({
    required String name,
    required String mobile,
    required String nationalID,
    required String password,
  }) async {
    var formData = json.encode({
      'name': name,
      'phone': mobile,
      'password': password,
      'nationalId': nationalID,
    });
    try {
      emit(AppRegisterLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        registerURL,
        data: formData,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: {
            'Accept': 'application/json',
            'Accept-Language': sharedLanguage,
          },
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      if (kDebugMode) {
        print('response : $response');
        print('responseJsonB : $responseJsonB');
        print('responseJson : $responseJson');
      }
      userResourceModel = UserResourceModel.fromJson(responseJson);
      if (kDebugMode) {
        print('userResourceModel : $userResourceModel');
      }
      if (kDebugMode) {
        print('response : $response');
        print('responseJsonB : $responseJsonB');
        print('convertedResponse : $convertedResponse');
        print('responseJson : $responseJson');
        print('userResourceModel : ${userResourceModel?.extra?.token}');
      }
      emit(AppRegisterSuccessState(userResourceModel!));
    } catch (error) {
      if (kDebugMode) {
        print('error : $error');
      }
      emit(AppRegisterErrorState(error.toString()));
    }
  }

  Future login({
    required String mobile,
    required String password,
  }) async {
    var formData = {
      'phone': mobile,
      'password': password,
    };
    try {
      emit(AppLoginLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        loginURL,
        data: formData,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: {
            'Accept': 'application/json',
            'Accept-Language': sharedLanguage,
          },
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      userResourceModel = UserResourceModel.fromJson(responseJson);
      // if (kDebugMode) {
      //   print('response : $response');
      //   print('responseJsonB : $responseJsonB');
      //   print('convertedResponse : $convertedResponse');
      //   print('responseJson : $responseJson');
      //   print('userResourceModel : ${userResourceModel?.extra?.token}');
      // }
      emit(AppLoginSuccessState(userResourceModel!));
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(AppLoginErrorState(error.toString()));
    }
  }

  Future completeProfile({
    required int countryId,
    required int cityId,
    required int branchId,
    required String gender,
  }) async {
    var formData = {
      'countryId': countryId,
      'cityId': cityId,
      'branchId': branchId,
      'gender': gender,
    };
    try {
      emit(AppCompleteProfileLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        completeProfileURL,
        data: formData,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: {
            'Accept': 'application/json',
            'Accept-Language': sharedLanguage,
            'Authorization': 'Bearer $extraToken',
          },
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      if (kDebugMode) {
        print('extraToken: $extraToken');
        print('headers: ${formData.entries}');
        print('response: $response');
        print('responseJsonB: $responseJsonB');
        print('convertedResponse: $convertedResponse');
        print('responseJson: $responseJson');
      }
      // userResourceModel = UserResourceModel.fromJson(responseJson);
      CacheHelper.saveData(key: 'extraCountryId', value: countryId);
      CacheHelper.saveData(key: 'extraCityId', value: cityId);
      CacheHelper.saveData(key: 'extraBranchId', value: branchId);
      if (kDebugMode) {
        print('userResourceModel : ${userResourceModel?.extra?.token}');
      }
      emit(AppCompleteProfileSuccessState(userResourceModel!));
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(AppCompleteProfileErrorState(error.toString()));
    }
  }

  Future createToken({
    required String mobile,
  }) async {
    emit(AppCreateTokenLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': sharedLanguage,
    };
    var formData = {
      'phone': mobile,
    };
    try {
      Dio dio = Dio();
      var response = await dio.post(
        createTokenURL,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
        data: formData,
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      createTokenModel = CreateTokenModel.fromJson(responseJson);
      emit(AppCreateTokenSuccessState(createTokenModel!));
    } catch (error) {
      emit(AppCreateTokenErrorState(error.toString()));
    }
  }

  Future resetPassword({
    required String newPassword,
    required String? resetToken,
  }) async {
    emit(AppResetPasswordLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': sharedLanguage,
    };
    var formData = {
      'newPassword': newPassword,
      'resetToken': resetToken,
    };
    try {
      Dio dio = Dio();
      var response = await dio.post(
        resetPasswordURL,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
        data: formData,
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      if (kDebugMode) {
        print('responseJson : $responseJson');
      }
      resetPasswordModel = ResetPasswordModel.fromJson(responseJson);
      emit(AppResetPasswordSuccessState(resetPasswordModel!));
    } catch (error) {
      emit(AppResetPasswordErrorState(error.toString()));
    }
  }

  Future getRelations() async {
    emit(AppGetRelationsLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': sharedLanguage,
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        relationsURL,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      relationsModel = RelationsModel.fromJson(responseJson);
      relationsNames = relationsModel?.data;
      for (var i = 0; i < relationsNames!.length; i++) {
        relationsName.add(relationsNames?[i].title);
      }
      emit(AppGetRelationsSuccessState(relationsModel!));
    } catch (error) {
      emit(AppGetRelationsErrorState(error.toString()));
    }
  }

  Future getCountry() async {
    emit(AppGetCountriesLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': sharedLanguage,
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        countryURL,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      countryModel = CountryModel.fromJson(responseJson);
      emit(AppGetCountriesSuccessState(countryModel!));
    } catch (error) {
      emit(AppGetCountriesErrorState(error.toString()));
    }
  }

  Future getCarouselData() async {
    emit(AppGetCarouselLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': sharedLanguage,
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        slidersURL,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      carouselModel = CarouselModel.fromJson(responseJson);
      emit(AppGetCarouselSuccessState(carouselModel!));
    } catch (error) {
      emit(AppGetCarouselErrorState(error.toString()));
    }
  }

  Future getCity({
    required int countryId,
  }) async {
    emit(AppGetCitiesLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': sharedLanguage,
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        '$cityURL?countryId=$countryId',
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      cityModel = CityModel.fromJson(responseJson);
      emit(AppGetCitiesSuccessState(cityModel!));
    } catch (error) {
      emit(AppGetCitiesErrorState(error.toString()));
    }
  }

  Future getBranch({
    required int cityID,
  }) async {
    emit(AppGetBranchesLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': sharedLanguage,
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        '$branchURL?cityId=$cityID',
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      branchModel = null;
      branchModel = BranchModel.fromJson(responseJson);
      branchNames = branchModel?.data;
      for (var i = 0; i < branchNames!.length; i++) {
        branchName.add(branchNames?[i].title);
      }
      emit(AppGetBranchesSuccessState(branchModel!));
    } catch (error) {
      emit(AppGetBranchesErrorState(error.toString()));
    }
  }

  Future verify() async {
    emit(AppGetVerifyLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': sharedLanguage,
      'Authorization': 'Bearer $extraToken',
    };
    try {
      Dio dio = Dio();
      var response = await dio.get(
        verificationURL,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      verifyModel = VerifyModel.fromJson(responseJson);
      emit(AppGetVerifySuccessState(verifyModel!));
    } catch (error) {
      emit(AppGetVerifyErrorState());
    }
  }


  Future getTests({
    required String categoriesId,
  }) async {
    try {
      emit(AppGetTestsLoadingState());
      Dio dio = Dio();
      var response = await dio.get(
        '$testsURL?categoryId=$categoriesId',
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: {
            'Accept': 'application/json',
            'Accept-Language': sharedLanguage,
          },
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      testsModel = TestsModel.fromJson(responseJson);
      // if (kDebugMode) {
      //   print('response : $response');
      //   print('responseJsonB : $responseJsonB');
      //   print('convertedResponse : $convertedResponse');
      //   print('responseJson : $responseJson');
      //   print('testsModel : ${testsModel?.extra?.token}');
      // }
      emit(AppGetTestsSuccessState(testsModel!));
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(AppLoginErrorState(error.toString()));
    }
  }

  IconData loginSufIcon = Icons.visibility_off;
  bool loginIsPassword = true;

  bool? isVisitor;

  bool isEnglish = true;

  String? local = sharedLanguage;

  dynamic changeLanguage() {
    isEnglish = !isEnglish;
    local = isEnglish ? local = 'en' : local = 'ar';
    CacheHelper.saveData(key: 'local', value: local);
    sharedLanguage = local;
    if (kDebugMode) {
      print('sharedLanguage $sharedLanguage');
      print('local $local');
    }
    changeBottomScreen(0);
    getCountry();
    getCity(countryId: extraCountryId!);
    getBranch(cityID: extraCityId!);
    getCarouselData();
    getRelations();
  }

  void loginChangePasswordVisibility() {
    loginIsPassword = !loginIsPassword;
    loginSufIcon = loginIsPassword ? Icons.visibility : Icons.visibility_off;
    emit(AppLoginChangePasswordVisibilityState());
  }

  IconData signUpSufIcon = Icons.visibility_off;
  bool signUpIsPassword = true;

  void signUpChangePasswordVisibility() {
    signUpIsPassword = !signUpIsPassword;
    signUpSufIcon = signUpIsPassword ? Icons.visibility : Icons.visibility_off;
    emit(AppSignUpChangePasswordVisibilityState());
  }

  IconData resetSufIcon = Icons.visibility_off;
  bool resetIsPassword = true;

  void resetChangePasswordVisibility() {
    resetIsPassword = !resetIsPassword;
    resetSufIcon = resetIsPassword ? Icons.visibility : Icons.visibility_off;
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
    if (index == 1) {
      if (fromHome) {
        currentIndex = index;
        tapIndex = 1;
      } else {
        currentIndex = index;
        tapIndex = 0;
      }
    } else {
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

  void signOut(context) async {
    CacheHelper.removeData(key: 'verified').then((value) {
      CacheHelper.removeData(key: 'token').then((value) {
        extraToken = null;
        if (value) {
          navigateAndFinish(
            context,
            OnBoardingScreen(isSignOut: true),
          );
        }
        emit(AppLogoutSuccessState());
      });
    });
  }

}