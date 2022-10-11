import 'package:hq/models/auth_models/create_token_model.dart';
import 'package:hq/models/auth_models/reset_password_model.dart';
import 'package:hq/models/auth_models/verify_model.dart';
import 'package:hq/models/auth_models/user_resource_model.dart';
import 'package:hq/models/cores_models/branch_model.dart';
import 'package:hq/models/cores_models/carousel_model.dart';
import 'package:hq/models/cores_models/city_model.dart';
import 'package:hq/models/cores_models/country_model.dart';
import 'package:hq/models/cores_models/relations_model.dart';
import 'package:hq/models/profile_models/terms_model.dart';
import 'package:hq/models/test_models/categories_model.dart';
import 'package:hq/models/test_models/offers_model.dart';
import 'package:hq/models/test_models/tests_model.dart';

abstract class AppStates {}

class InitialAppStates extends AppStates{}

class AppLoginChangePasswordVisibilityState extends AppStates{}

class AppSignUpChangePasswordVisibilityState extends AppStates{}

class AppResetChangePasswordVisibilityState extends AppStates{}

class AppResetConfirmChangePasswordVisibilityState extends AppStates{}

class AppIdNumberVisibilityState extends AppStates{}

class AppChangeBottomNavState extends AppStates{}

class AppChangeCarouselState extends AppStates{}

class AppRegisterLoadingState extends AppStates{}

class AppRegisterSuccessState extends AppStates{
  final UserResourceModel userResourceModel;
  AppRegisterSuccessState(this.userResourceModel);
}

class AppRegisterErrorState extends AppStates{
  final String error;
  AppRegisterErrorState(this.error);
}

class AppLoginLoadingState extends AppStates{}

class AppLoginSuccessState extends AppStates{
  final UserResourceModel userResourceModel;
  AppLoginSuccessState(this.userResourceModel);
}

class AppLoginErrorState extends AppStates{
  final String error;
  AppLoginErrorState(this.error);
}

class AppGetProfileLoadingState extends AppStates{}

class AppGetProfileSuccessState extends AppStates{
  final UserResourceModel userResourceModel;
  AppGetProfileSuccessState(this.userResourceModel);
}

class AppGetProfileErrorState extends AppStates{
  final String error;
  AppGetProfileErrorState(this.error);
}

class AppCompleteProfileLoadingState extends AppStates{}

class AppCompleteProfileSuccessState extends AppStates{
  final UserResourceModel userResourceModel;
  AppCompleteProfileSuccessState(this.userResourceModel);
}

class AppCompleteProfileErrorState extends AppStates{
  final String error;
  AppCompleteProfileErrorState(this.error);
}

class AppGetCountriesLoadingState extends AppStates{}

class AppGetCountriesSuccessState extends AppStates{
  final CountryModel countriesModel;
  AppGetCountriesSuccessState(this.countriesModel);
}

class AppGetCountriesErrorState extends AppStates{
  final String error;
  AppGetCountriesErrorState(this.error);
}

class AppGetRelationsLoadingState extends AppStates{}

class AppGetRelationsSuccessState extends AppStates{
  final RelationsModel relationsModel;
  AppGetRelationsSuccessState(this.relationsModel);
}

class AppGetRelationsErrorState extends AppStates{
  final String error;
  AppGetRelationsErrorState(this.error);
}

class AppGetVerifyLoadingState extends AppStates{}

class AppGetVerifySuccessState extends AppStates{
  final SuccessModel successModel;
  AppGetVerifySuccessState(this.successModel);
}

class AppGetVerifyErrorState extends AppStates{}

class AppEditProfileLoadingState extends AppStates{}

class AppEditProfileSuccessState extends AppStates{
  final SuccessModel successModel;
  AppEditProfileSuccessState(this.successModel);
}

class AppEditProfileErrorState extends AppStates{}


class AppGetCitiesLoadingState extends AppStates{}

class AppGetCitiesSuccessState extends AppStates{
  final CityModel cityModel;
  AppGetCitiesSuccessState(this.cityModel);
}

class AppGetCitiesErrorState extends AppStates{
  final String error;
  AppGetCitiesErrorState(this.error);
}

class AppStartLoadingState extends AppStates{}

class AppEndLoadingState extends AppStates{}

class AppCreateTokenLoadingState extends AppStates{}

class AppCreateTokenSuccessState extends AppStates{
  final CreateTokenModel createTokenModel;
  AppCreateTokenSuccessState(this.createTokenModel);
}

class AppCreateTokenErrorState extends AppStates{
  final String error;
  AppCreateTokenErrorState(this.error);
}

class AppResetPasswordLoadingState extends AppStates{}

class AppResetPasswordSuccessState extends AppStates{
  final ResetPasswordModel resetPasswordModel;
  AppResetPasswordSuccessState(this.resetPasswordModel);
}

class AppResetPasswordErrorState extends AppStates{
  final String error;
  AppResetPasswordErrorState(this.error);
}

class AppGetBranchesLoadingState extends AppStates{}

class AppGetBranchesSuccessState extends AppStates{
  final BranchModel branchModel;
  AppGetBranchesSuccessState(this.branchModel);
}

class AppGetBranchesErrorState extends AppStates{
  final String error;
  AppGetBranchesErrorState(this.error);
}

class AppGetCarouselLoadingState extends AppStates{}

class AppGetCarouselSuccessState extends AppStates{
  final CarouselModel carouselModel;
  AppGetCarouselSuccessState(this.carouselModel);
}

class AppGetCarouselErrorState extends AppStates{
  final String error;
  AppGetCarouselErrorState(this.error);
}

class AppGetCategoriesLoadingState extends AppStates{}

class AppGetCategoriesSuccessState extends AppStates{
  final CategoriesModel categoriesModel;
  AppGetCategoriesSuccessState(this.categoriesModel);
}

class AppGetCategoriesErrorState extends AppStates{
  final String error;
  AppGetCategoriesErrorState(this.error);
}

class AppGetOffersLoadingState extends AppStates{}

class AppGetOffersSuccessState extends AppStates{
  final OffersModel offersModel;
  AppGetOffersSuccessState(this.offersModel);
}

class AppGetOffersErrorState extends AppStates{
  final String error;
  AppGetOffersErrorState(this.error);
}

class AppGetTestsLoadingState extends AppStates{}

class AppGetTestsSuccessState extends AppStates{
  final TestsModel testsModel;
  AppGetTestsSuccessState(this.testsModel);
}

class AppGetTestsErrorState extends AppStates{
  final String error;
  AppGetTestsErrorState(this.error);
}

class AppProfileImagePickedSuccessState extends AppStates{}

class AppProfileImagePickedErrorState extends AppStates{}

class AppGetTermsLoadingState extends AppStates{}

class AppGetTermsSuccessState extends AppStates{
  final TermsModel termsModel;
  AppGetTermsSuccessState(this.termsModel);
}

class AppGetTermsErrorState extends AppStates{
  final String error;
  AppGetTermsErrorState(this.error);
}

class AppLogoutSuccessState extends AppStates{}