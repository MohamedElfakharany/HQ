import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/intro_screens/auth/login_screen.dart';
import 'package:hq/screens/intro_screens/reset_password/verification_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final userNameController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final nationalIdController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final _focusNodes =
      Iterable<int>.generate(4).map((_) => FocusNode()).toList();

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
      codeAutoRetrievalTimeout: (String verificationId) {
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppRegisterSuccessState) {
          if (state.userResourceModel.status) {
            extraToken = state.userResourceModel.extra!.token;
            fetchOtp(mobileController.text.toString()).then(
              (value) async => {
                if (verificationId != "")
                  {
                    await Navigator.push(
                      context,
                      FadeRoute(
                        page: VerificationScreen(
                          verificationId: verificationId,
                          isRegister: true,
                          mobileNumber: mobileController.text.toString(),
                        ),
                      ),
                    ),
                  },
              },
            );
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(state.userResourceModel.message),
                    content: Text(LocaleKeys.txtLoginAgain.tr()),
                  );
                });
          }
        } else if (state is AppRegisterErrorState) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(LocaleKeys.txtLoginAgain.tr()),
                );
              });
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    verticalMediumSpace,
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          LocaleKeys.BtnSignUp.tr(),
                          style: titleStyle.copyWith(
                              fontSize: 35.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    verticalMiniSpace,
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          LocaleKeys.registerTxtSecondary.tr(),
                          style: titleStyle.copyWith(
                              fontWeight: FontWeight.normal,
                              color: greyLightColor),
                        ),
                      ),
                    ),
                    verticalMiniSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: DefaultFormField(
                        height: 90,
                        focusNode: _focusNodes[0],
                        controller: userNameController,
                        type: TextInputType.text,
                        validatedText: LocaleKeys.txtFieldName.tr(),
                        label: LocaleKeys.txtFieldName.tr(),
                        onTap: () {},
                      ),
                    ),
                    verticalMiniSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: DefaultFormField(
                        height: 90,
                        focusNode: _focusNodes[1],
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
                        focusNode: _focusNodes[2],
                        controller: passwordController,
                        type: TextInputType.text,
                        validatedText: LocaleKeys.txtFieldPassword.tr(),
                        obscureText: cubit.signUpIsPassword,
                        suffixIcon: cubit.signUpSufIcon,
                        label: LocaleKeys.txtFieldPassword.tr(),
                        suffixPressed: () {
                          cubit.signUpChangePasswordVisibility();
                        },
                        onTap: () {},
                      ),
                    ),
                    verticalMiniSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: DefaultFormField(
                        height: 90,
                        focusNode: _focusNodes[3],
                        controller: nationalIdController,
                        type: TextInputType.number,
                        label: LocaleKeys.txtFieldIdNumber.tr(),
                        onTap: () {},
                        validatedText: LocaleKeys.txtFieldIdNumber.tr(),
                      ),
                    ),
                    verticalMiniSpace,
                    Column(
                      children: [
                        Text(
                          LocaleKeys.txtAgree.tr(),
                          style: subTitleSmallStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                showPopUp(
                                  context,
                                  Container(
                                    height: 500,
                                    width: width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsetsDirectional.only(
                                        end: 30.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        verticalMediumSpace,
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                LocaleKeys
                                                    .txtTitleOfOurTermsOfService
                                                    .tr(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: fontFamily,
                                                  fontWeight: FontWeight.bold,
                                                  color: blueColor,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              verticalMiniSpace,
                                              SizedBox(
                                                height: 350.0,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  child: Text(
                                                    LocaleKeys.onboardingBody
                                                        .tr(),
                                                    textAlign: TextAlign.center,
                                                    style: subTitleSmallStyle,
                                                  ),
                                                ),
                                              ),
                                              verticalMiniSpace,
                                              GeneralButton(
                                                title: LocaleKeys.BtnOk.tr(),
                                                onPress: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                LocaleKeys.txtTitleOfOurTermsOfService.tr(),
                                style: const TextStyle(color: blueColor),
                              ),
                            ),
                            // const Text(
                            //   'And',
                            //   style: subTitleSmallStyle,
                            // ),
                            TextButton(
                              onPressed: () {
                                showPopUp(
                                  context,
                                  Container(
                                    height: 500,
                                    width: width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsetsDirectional.only(
                                        end: 30.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        verticalMediumSpace,
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                LocaleKeys
                                                    .txtTitleOfOurPrivacyPolicy
                                                    .tr(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: fontFamily,
                                                  fontWeight: FontWeight.bold,
                                                  color: blueColor,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              verticalMiniSpace,
                                              SizedBox(
                                                height: 350.0,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  child: Text(
                                                    LocaleKeys.onboardingBody
                                                        .tr(),
                                                    textAlign: TextAlign.center,
                                                    style: subTitleSmallStyle,
                                                  ),
                                                ),
                                              ),
                                              verticalMiniSpace,
                                              GeneralButton(
                                                title: LocaleKeys.BtnOk.tr(),
                                                onPress: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                LocaleKeys.txtTitleOfOurPrivacyPolicy.tr(),
                                style: const TextStyle(color: blueColor),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    horizontalMiniSpace,
                    ConditionalBuilder(
                      condition: state is! AppRegisterLoadingState,
                      builder: (context) => GeneralButton(
                        title: LocaleKeys.BtnSignUp.tr(),
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            cubit.register(
                              name: userNameController.text,
                              nationalID: nationalIdController.text,
                              password: passwordController.text,
                              mobile: mobileController.text,
                            );
                          }
                          cubit.isVisitor = false;
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
                          LocaleKeys.registerTxtHaveAccount.tr(),
                          style: subTitleSmallStyle,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              FadeRoute(
                                page: const LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            LocaleKeys.BtnSignIn.tr(),
                            style: titleSmallStyle.copyWith(color: blueColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
