import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/intro_screens/auth/register/select_country_screen.dart';
import 'package:hq/screens/intro_screens/auth/register/sign_up_screen.dart';
import 'package:hq/screens/intro_screens/reset_password/forget_password_screen.dart';
import 'package:hq/screens/intro_screens/reset_password/verification_screen.dart';
import 'package:hq/screens/main_screens/home_layout_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final _focusNodes =
      Iterable<int>.generate(2).map((_) => FocusNode()).toList();

  dataSaving({
    required String tokenSave,
    required int countryId,
    required int cityId,
    required int branchId,
    required String isVerifiedSave,
  }) async {
    (await SharedPreferences.getInstance()).setString('token', tokenSave);
    (await SharedPreferences.getInstance()).setInt('extraCountryId', countryId);
    (await SharedPreferences.getInstance()).setInt('extraCityId', cityId);
    (await SharedPreferences.getInstance()).setInt('extraBranchId', branchId);
    (await SharedPreferences.getInstance())
        .setString('verified', isVerifiedSave);
    token = tokenSave;
    verified = isVerifiedSave;
    extraCountryId = countryId;
    extraCityId = cityId;
    extraBranchId = branchId;
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  String verificationId = "";

  Future<void> fetchOtp(String number) async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+2$number',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          if (kDebugMode) {
            print('The provided phone number is not valid.');
          }
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppLoginSuccessState) {
          if (state.userResourceModel.status) {
            if (state.userResourceModel.data!.isVerified == '0') {
              fetchOtp(mobileController.text.toString()).then((value) => {
                    Navigator.push(
                      context,
                      FadeRoute(
                        page: VerificationScreen(
                            mobileNumber: mobileController.text.toString(),verificationId: verificationId, isRegister: true,),
                      ),
                    ),
                  });
            } else {
              if (state.userResourceModel.data!.isCompleted == 0) {
                Navigator.push(
                  context,
                  FadeRoute(
                    page: const SelectCountryScreen(),
                  ),
                );
              } else {
                dataSaving(
                  tokenSave: state.userResourceModel.extra?.token,
                  isVerifiedSave: state.userResourceModel.data?.isVerified,
                  countryId: state.userResourceModel.data!.country!.id,
                  cityId: state.userResourceModel.data!.city!.id,
                  branchId: state.userResourceModel.data!.branch!.id,
                );
                navigateAndFinish(
                  context,
                  const HomeLayoutScreen(),
                );
              }
            }
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // title: Text(state.userResourceModel.message),
                  content: Text(
                    LocaleKeys.txtLoginError.tr(),
                  ),
                );
              },
            );
          }
        }
        if (state is AppLoginErrorState) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // title: Text(state.error.toString()),
                content: Text(
                  LocaleKeys.txtLoginError.tr(),
                ),
              );
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: whiteColor,
          appBar: GeneralAppBar(
            title: '',
          ),
          body: Form(
            key: formKey,
            child: KeyboardActions(
              tapOutsideBehavior: TapOutsideBehavior.translucentDismiss,
              config: KeyboardActionsConfig(
                // Define ``defaultDoneWidget`` only once in the config
                defaultDoneWidget: doneKeyboard(),
                actions: _focusNodes
                    .map((focusNode) =>
                        KeyboardActionsItem(focusNode: focusNode))
                    .toList(),
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  verticalMediumSpace,
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 150,
                      height: 125,
                    ),
                  ),
                  verticalMiniSpace,
                  Center(
                    child: Text(
                      LocaleKeys.loginTxtMain.tr(),
                      style: titleStyle.copyWith(
                          fontSize: 30.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  verticalMiniSpace,
                  Center(
                    child: Text(
                      LocaleKeys.loginTxtSecondary.tr(),
                      style: subTitleSmallStyle,
                    ),
                  ),
                  verticalMiniSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: DefaultFormField(
                      height: 90,
                      focusNode: _focusNodes[0],
                      controller: mobileController,
                      type: TextInputType.text,
                      validatedText: LocaleKeys.txtFieldMobile.tr(),
                      label: LocaleKeys.txtFieldMobile.tr(),
                      onTap: () {},
                    ),
                  ),
                  verticalMiniSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: DefaultFormField(
                      height: 90,
                      focusNode: _focusNodes[1],
                      controller: passwordController,
                      type: TextInputType.text,
                      validatedText: LocaleKeys.txtFieldPassword.tr(),
                      obscureText: cubit.loginIsPassword,
                      suffixIcon: cubit.loginSufIcon,
                      label: LocaleKeys.txtFieldPassword.tr(),
                      suffixPressed: () {
                        cubit.loginChangePasswordVisibility();
                      },
                      onTap: () {},
                    ),
                  ),
                  // verticalMiniSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            FadeRoute(
                              page: const ForgetPasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          LocaleKeys.BtnForgetPassword.tr(),
                          style: subTitleSmallStyle,
                        ),
                      ),
                      horizontalMiniSpace,
                    ],
                  ),
                  ConditionalBuilder(
                    condition: state is! AppLoginLoadingState,
                    builder: (context) => GeneralButton(
                      title: LocaleKeys.BtnSignIn.tr(),
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          cubit.isVisitor = false;
                          cubit.login(
                              mobile: mobileController.text,
                              password: passwordController.text);
                        }
                      },
                    ),
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                  verticalMediumSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.loginTxtDontHaveAccount.tr(),
                        style: subTitleSmallStyle,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            FadeRoute(
                              page: const SignUpScreen(),
                            ),
                          );
                        },
                        child: Text(
                          LocaleKeys.registerTxtMain.tr(),
                          style: titleSmallStyle.copyWith(color: blueColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
