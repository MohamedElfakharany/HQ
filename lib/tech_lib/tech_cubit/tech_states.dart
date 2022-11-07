import 'package:hq/models/patient_models/auth_models/verify_model.dart';
import 'package:hq/models/patient_models/auth_models/user_resource_model.dart';

abstract class AppTechStates {}

class InitialAppTechStates extends AppTechStates {}

class AppTechChangePasswordLoadingState extends AppTechStates {}

class AppTechChangePasswordSuccessState extends AppTechStates {
  final SuccessModel successModel;

  AppTechChangePasswordSuccessState(this.successModel);
}

class AppTechChangePasswordErrorState extends AppTechStates {
  final String error;

  AppTechChangePasswordErrorState(this.error);
}

class AppTechChangeBottomNavState extends AppTechStates {}

class AppTechLoginLoadingState extends AppTechStates {}

class AppTechEditProfileLoadingState extends AppTechStates {}

class AppTechEditProfileSuccessState extends AppTechStates {
  final SuccessModel successModel;

  AppTechEditProfileSuccessState(this.successModel);
}

class AppTechEditProfileErrorState extends AppTechStates {
  final String error;

  AppTechEditProfileErrorState(this.error);
}

class AppTechResetChangePasswordVisibilityState extends AppTechStates {}

class AppTechResetConfirmChangePasswordVisibilityState extends AppTechStates {}

class AppTechLoginSuccessState extends AppTechStates {
  final UserResourceModel userResourceModel;

  AppTechLoginSuccessState(this.userResourceModel);
}

class AppTechLoginErrorState extends AppTechStates {
  final String error;

  AppTechLoginErrorState(this.error);
}

class AppTechGetProfileLoadingState extends AppTechStates {}

class AppTechGetProfileSuccessState extends AppTechStates {
  final UserResourceModel userResourceModel;

  AppTechGetProfileSuccessState(this.userResourceModel);
}

class AppTechGetProfileErrorState extends AppTechStates {
  final String error;

  AppTechGetProfileErrorState(this.error);
}

class AppTechProfileImagePickedSuccessState extends AppTechStates {}

class AppTechProfileImagePickedErrorState extends AppTechStates {}

class AppTechLogoutSuccessState extends AppTechStates {}
