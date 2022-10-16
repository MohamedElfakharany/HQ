import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/models/auth_models/create_token_model.dart';
import 'package:hq/models/auth_models/reset_password_model.dart';
import 'package:hq/models/cores_models/branch_model.dart';
import 'package:hq/models/cores_models/carousel_model.dart';
import 'package:hq/models/cores_models/city_model.dart';
import 'package:hq/models/cores_models/country_model.dart';
import 'package:hq/models/cores_models/relations_model.dart';
import 'package:hq/models/auth_models/verify_model.dart';
import 'package:hq/models/auth_models/user_resource_model.dart';
import 'package:hq/models/profile_models/families_model.dart';
import 'package:hq/models/profile_models/terms_model.dart';
import 'package:hq/models/test_models/categories_model.dart';
import 'package:hq/models/test_models/offers_model.dart';
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
import 'package:hq/models/test_models/tests_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppStates());

  static AppCubit get(context) => BlocProvider.of(context);

  UserResourceModel? userResourceModel;
  CountryModel? countryModel;
  CityModel? cityModel;
  BranchModel? branchModel;
  SuccessModel? successModel;
  CarouselModel? carouselModel;
  RelationsModel? relationsModel;
  CreateTokenModel? createTokenModel;
  ResetPasswordModel? resetPasswordModel;
  TestsModel? testsModel;
  CategoriesModel? categoriesModel;
  OffersModel? offersModel;
  TermsModel? termsModel;
  FamiliesModel? familiesModel;

  List<BranchesDataModel>? branchNames = [];
  List<String> branchName = [];

  List<RelationsDataModel>? relationsNames = [];
  List<String> relationsName = [];

  int? branchIdList;

  int? relationIdList;

  void selectBranch({required String name}){
    for (int i = 0; i < branchNames!.length; i++){
      if (branchNames![i].title == name){
        branchIdList = branchNames![i].id;
        getBranch(cityID: branchIdList!);
      }
    }
  }

  void selectRelationId({required String relationName}){
    for (int i = 0 ; i< relationsNames!.length ; i++){
      if (relationsNames![i].title == relationName){
        relationIdList = relationsNames![i].id;
      }
    }
  }

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
            'Authorization': 'Bearer $token',
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

  Future changeLocation({
    required int countryId,
    required int cityId,
    required int branchId,
  }) async {
    var formData = {
      'countryId': countryId,
      'cityId': cityId,
      'branchId': branchId,
    };
    try {
      emit(AppChangeLocationLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        changeLocationURL,
        data: formData,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: {
            'Accept': 'application/json',
            'Accept-Language': sharedLanguage,
            'Authorization': 'Bearer $token',
          },
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      successModel = SuccessModel.fromJson(responseJson);
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

      emit(AppChangeLocationSuccessState(successModel!));
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(AppChangeLocationErrorState(error.toString()));
    }
  }

  saveExtraLocation({
    required int extraCountryId1,
    required int extraCityId1,
    required int extraBranchId1,
    required String extraBranchTitle1,
  }) async {
    (await SharedPreferences.getInstance())
        .setInt('extraCountryId', extraCountryId1);
    (await SharedPreferences.getInstance()).setInt('extraCityId', extraCityId1);
    (await SharedPreferences.getInstance())
        .setInt('extraBranchId', extraBranchId1);
    (await SharedPreferences.getInstance())
        .setString('extraBranchTitle', extraBranchTitle1);
    extraCountryId = extraCountryId1;
    extraCityId = extraCityId1;
    extraBranchId = extraBranchId1;
    extraBranchTitle = extraBranchTitle1;
  }

  Future getProfile() async {
    try {
      emit(AppGetProfileLoadingState());
      Dio dio = Dio();
      var response = await dio.get(
        getProfileURL,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: {
            'Accept': 'application/json',
            'Accept-Language': sharedLanguage,
            'Authorization': 'Bearer $token',
          },
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      if (kDebugMode) {
        print('responseJson : $responseJson');
      }
      userResourceModel = UserResourceModel.fromJson(responseJson);
      if (kDebugMode) {
        print('userResourceModel : ${userResourceModel?.data?.profile}');
      }
      emit(AppGetProfileSuccessState(userResourceModel!));
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(AppGetProfileErrorState(error.toString()));
    }
  }

  File? memberImage;

  File? editMemberImage;

  Future getFamilies() async {
    try {
      emit(AppGetFamiliesLoadingState());
      Dio dio = Dio();
      var response = await dio.get(
        familiesURL,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: {
            'Accept': 'application/json',
            'Accept-Language': sharedLanguage,
            'Authorization': 'Bearer $token',
          },
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      if (kDebugMode) {
        print('responseJson : $responseJson');
      }
      familiesModel = FamiliesModel.fromJson(responseJson);
      if (kDebugMode) {
        print('familiesModel : ${familiesModel?.data?.first.profile}');
      }
      emit(AppGetFamiliesSuccessState(familiesModel!));
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(AppGetFamiliesErrorState(error.toString()));
    }
  }

  Future<void> getMemberImage() async {
    try {
      XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        memberImage = File(pickedImage.path);
        if (kDebugMode) {
          print('memberImage : $memberImage');
        }
        emit(AppProfileImagePickedSuccessState());
      } else {
        if (kDebugMode) {
          print('no image selected');
          print(memberImage);
        }
        emit(AppProfileImagePickedErrorState());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> getEditMemberImage() async {
    try {
      XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        editMemberImage = File(pickedImage.path);
        if (kDebugMode) {
          print('editMemberImage : $editMemberImage');
        }
        emit(AppProfileImagePickedSuccessState());
      } else {
        if (kDebugMode) {
          print('no image selected');
          print(editMemberImage);
        }
        emit(AppProfileImagePickedErrorState());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future createMember({
    required int relationId,
    required String name,
    required String phone,
    required String birthday,
    required String gender,
    required String profile,
  }) async {
    emit(AppCreateMemberLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = FormData.fromMap(
      {
        'relationId': relationId,
        'name': name,
        'phone': phone,
        'birthday': birthday,
        'gender': gender,
        'profile': memberImage == null
            ? Uri.file(userResourceModel?.data?.profile).pathSegments.last
            : await MultipartFile.fromFile(
          memberImage!.path,
          filename: profile,
        ),
      },
    );
    try {
      Dio dio = Dio();
      var response = await dio.post(
        createMemberURL,
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
        print('formData : ${formData.fields}');
      }
      successModel = SuccessModel.fromJson(responseJson);
      emit(AppCreateMemberSuccessState(successModel!));
    } catch (error) {
      emit(AppCreateMemberErrorState(error.toString()));
    }
  }

  Future editMember({
    required String name,
    required String phone,
    required String profile,
  }) async {
    emit(AppEditMemberLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = FormData.fromMap(
      {
        'name': name,
        'phone': phone,
        'profile': editMemberImage == null
            ? Uri.file(userResourceModel?.data?.profile).pathSegments.last
            : await MultipartFile.fromFile(
          editMemberImage!.path,
          filename: profile,
        ),
      },
    );
    try {
      Dio dio = Dio();
      var response = await dio.put(
        editMemberURL,
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
        print('editMemberURL : $editMemberURL');
        print('responseJson : $responseJson');
        print('formData : ${formData.fields}');
      }
      successModel = SuccessModel.fromJson(responseJson);
      emit(AppEditMemberSuccessState(successModel!));
    } catch (error) {
      emit(AppEditMemberErrorState(error.toString()));
    }
  }

  Future deleteMember({
    required int memberId,
  }) async {
    emit(AppDeleteMemberLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = {
      'memberId': memberId,
    };
    try {
      Dio dio = Dio();
      var response = await dio.delete(
        deleteMemberURL,
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
      successModel = SuccessModel.fromJson(responseJson);
      emit(AppDeleteMemberSuccessState(successModel!));
    } catch (error) {
      emit(AppDeleteMemberErrorState(error.toString()));
    }
  }

  Future editProfile({
    required String name,
    required String email,
    required String gender,
    required String birthday,
    required String profile,
  }) async {
    emit(AppEditProfileLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = FormData.fromMap(
      {
        'name': name,
        'email': email,
        'gender': gender,
        'birthday': birthday,
        'profile': profileImage == null
            ? Uri.file(userResourceModel?.data?.profile).pathSegments.last
            : await MultipartFile.fromFile(
          profileImage!.path,
          filename: profile,
        ),
      },
    );
    try {
      Dio dio = Dio();
      var response = await dio.post(
        editProfileURL,
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
        print('formData : ${formData.fields}');
      }
      successModel = SuccessModel.fromJson(responseJson);
      emit(AppEditProfileSuccessState(successModel!));
    } catch (error) {
      emit(AppEditProfileErrorState(error.toString()));
    }
  }

  Future getTerms() async {

    try {
      emit(AppGetTermsLoadingState());
      Dio dio = Dio();
      var response = await dio.get(
        getTermsPrivacyURL,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: {
            'Accept': 'application/json',
            'Accept-Language': sharedLanguage,
            'Authorization': 'Bearer $token',
          },
        ),
      );
      var responseJsonB = response.data;
      var convertedResponse = utf8.decode(responseJsonB);
      var responseJson = json.decode(convertedResponse);
      termsModel = TermsModel.fromJson(responseJson);
      emit(AppGetTermsSuccessState(termsModel!));
    } catch (error) {
      emit(AppGetTermsErrorState(error.toString()));
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
      resetPasswordModel = ResetPasswordModel.fromJson(responseJson);
      if (kDebugMode) {
        print('headers.entries : ${headers.entries}');
        print('formData.entries : ${formData.entries}');
        print('responseJson : $responseJson');
        print('resetPasswordModel : ${resetPasswordModel!.data}');
      }
      emit(AppResetPasswordSuccessState(resetPasswordModel!));
    } catch (error) {
      emit(AppResetPasswordErrorState(error.toString()));
    }
  }

  String? verificationId = "";
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> fetchOtp({required String number}) async {
    emit(AppStartFetchOTPState());
    await auth.verifyPhoneNumber(
      phoneNumber: '+2$number',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((v) => {});
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          if (kDebugMode) {
            print('The provided phone number is not valid.');
          }
        }
      },
      codeSent: (String verificationIdC, int? resendToken) async {
        verificationId = verificationIdC;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    emit(AppEndFetchOTPState());

    if (kDebugMode) {
      print('verificationId Sign In : $verificationId');
    }
  }

  Future changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(AppChangePasswordLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Accept-Language': sharedLanguage,
      'Authorization': 'Bearer $token',
    };
    var formData = {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
    try {
      Dio dio = Dio();
      var response = await dio.post(
        changePasswordURL,
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
      successModel = SuccessModel.fromJson(responseJson);
      emit(AppChangePasswordSuccessState(successModel!));
    } catch (error) {
      emit(AppChangePasswordErrorState(error.toString()));
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
        print(relationsName);
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
      branchName = [];
      branchNames = branchModel?.data;
      for (var i = 0; i < branchNames!.length; i++) {
        branchName.add(branchNames?[i].title);
      }
      if (kDebugMode) {
        print('branchNames!.length : ${branchNames!.length}');
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
      'Authorization': 'Bearer $token',
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
      if (kDebugMode) {
        print(responseJson);
        print(headers.entries);
      }
      (await SharedPreferences.getInstance()).setInt('verified', 1);
      successModel = SuccessModel.fromJson(responseJson);
      if (kDebugMode) {
        print('successModel : ${successModel!.status}');
      }
      emit(AppGetVerifySuccessState(successModel!));
    } catch (error) {
      emit(AppGetVerifyErrorState());
    }
  }

  Future getCategories() async {
    try {
      emit(AppGetCategoriesLoadingState());
      Dio dio = Dio();
      var response = await dio.get(
        categoriesURL,
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
      categoriesModel = CategoriesModel.fromJson(responseJson);
      emit(AppGetCategoriesSuccessState(categoriesModel!));
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(AppGetCategoriesErrorState(error.toString()));
    }
  }

  Future getOffers() async {
    try {
      emit(AppGetOffersLoadingState());
      Dio dio = Dio();
      var response = await dio.get(
        offersURL,
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
      offersModel = OffersModel.fromJson(responseJson);
      emit(AppGetOffersSuccessState(offersModel!));
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(AppGetOffersErrorState(error.toString()));
    }
  }

  Future getTests({
    String? categoriesId,
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
      if (kDebugMode) {
        print('testsModel responseJson : $responseJson');
      }
      emit(AppGetTestsSuccessState(testsModel!));
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      emit(AppGetTestsErrorState(error.toString()));
    }
  }

  dataSaving({
    required String extraTokenSave,
    required String extraBranchTitle1,
    required int countryId,
    required int cityId,
    required int branchId,
    required int isVerifiedSave,
  }) async {
    (await SharedPreferences.getInstance()).setString('token', extraTokenSave);
    (await SharedPreferences.getInstance())
        .setString('extraBranchTitle', extraBranchTitle1);
    (await SharedPreferences.getInstance()).setInt('extraCountryId', countryId);
    (await SharedPreferences.getInstance()).setInt('extraCityId', cityId);
    (await SharedPreferences.getInstance()).setInt('extraBranchId', branchId);
    (await SharedPreferences.getInstance()).setInt('verified', isVerifiedSave);
    token = extraTokenSave;
    verified = isVerifiedSave;
    extraCountryId = countryId;
    extraCityId = cityId;
    extraBranchId = branchId;
    extraBranchTitle = extraBranchTitle1;
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
    changeBottomScreen(0);
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

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    try {
      XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        profileImage = File(pickedImage.path);
        if (kDebugMode) {
          print('profileImage : $profileImage');
        }
        emit(AppProfileImagePickedSuccessState());
      } else {
        if (kDebugMode) {
          print('no image selected');
          print(profileImage);
        }
        emit(AppProfileImagePickedErrorState());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void signOut(context) async {
    CacheHelper.removeData(key: 'verified').then((value) {
      CacheHelper.removeData(key: 'token').then((value) {
        extraToken = null;
        token = null;

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
