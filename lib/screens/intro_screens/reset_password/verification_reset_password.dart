// ignore_for_file: must_be_immutable, use_build_context_synchronously, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/intro_screens/reset_password/reset_password_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/translations/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationResetScreen extends StatefulWidget {
  VerificationResetScreen({
    Key? key,
    required this.mobileNumber,
    required this.phoneCode,
    this.resetToken,
  }) : super(key: key);
  String? resetToken;
  String phoneCode = "";
  String mobileNumber = "";

  @override
  State<VerificationResetScreen> createState() =>
      _VerificationResetScreenState();
}

class _VerificationResetScreenState extends State<VerificationResetScreen> {
  final codeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String? verificationId = "";
  FirebaseAuth auth = FirebaseAuth.instance;

  Future fetchOtp({required String number, required String phoneCode}) async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+$phoneCode$number',
      timeout: const Duration(seconds: 60),
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
      codeSent: (String verificationIdC, int? resendToken) async {
        verificationId = verificationIdC;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  bool isFirst = true;

  Future<void> verify() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: verificationId.toString(),
      smsCode: codeController.text,
    );
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        Navigator.push(
          context,
          FadeRoute(
            page: ResetPasswordScreen(resetToken: widget.resetToken),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return
              // const Center(child: CircularProgressIndicator.adaptive());
              AlertDialog(
            content: Text(
              e.code,
            ),
          );
        },
      );
      if (kDebugMode) {
        print("catch");
      }
    }
  }

  saveVerified({required int verified1}) async {
    (await SharedPreferences.getInstance()).setInt('verified', verified1);
  }

  @override
  void initState() {
    super.initState();
    if (isFirst) {
      isFirst = false;
      fetchOtp(number: widget.mobileNumber, phoneCode: widget.phoneCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
        if (state is AppResetPasswordSuccessState) {
          if (state.resetPasswordModel.status) {
            showToast(
                msg: state.resetPasswordModel.message,
                state: ToastState.success);
            AppCubit.get(context).signOut(context);
          } else {
            Navigator.pop(context);
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(state.resetPasswordModel.message),
                );
              },
            );
          }
        } else if (state is AppChangeNumberErrorState) {
          Navigator.pop(context);
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(state.error),
              );
            },
          );
        }
      },
      builder: (context, state) {
        print('widget.resetToken : ${widget.resetToken}');
        return Scaffold(
          backgroundColor: whiteColor,
          appBar: GeneralAppBar(
            title: '',
          ),
          body: Form(
            key: formKey,
            child: ConditionalBuilder(
              condition: state is! AppCreateTokenLoadingState,
              builder: (context) => ListView(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Text(
                            LocaleKeys.verifyTxtMain.tr(),
                            style: titleStyle.copyWith(
                                fontSize: 30.0, fontWeight: FontWeight.w600),
                          ),
                          horizontalLargeSpace,
                          const Icon(
                            Icons.email,
                            color: greyLightColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalMiniSpace,
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        LocaleKeys.resetTxtThird.tr(),
                        style: titleSmallStyle.copyWith(
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
                      controller: codeController,
                      type: TextInputType.phone,
                      validatedText: LocaleKeys.txtFieldCodeReset.tr(),
                      label: LocaleKeys.txtFieldCodeReset.tr(),
                      onTap: () {},
                    ),
                  ),
                  verticalMediumSpace,
                  ConditionalBuilder(
                    condition: verificationId != null,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GeneralButton(
                        title: LocaleKeys.BtnVerify.tr(),
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            verify();
                          }
                        },
                      ),
                    ),
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                  verticalMediumSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.txtDidntReseveCode.tr(),
                        style: subTitleSmallStyle,
                      ),
                      TextButton(
                        onPressed: () {
                          codeController.text = '';
                          AppCubit.get(context)
                              .createToken(
                                  mobile: widget.mobileNumber.toString(),
                                  phoneCode: widget.phoneCode)
                              .then((v) {
                            fetchOtp(
                                number: widget.mobileNumber,
                                phoneCode: widget.phoneCode);
                          });
                        },
                        child: Text(
                          LocaleKeys.BtnResend.tr(),
                          style: titleSmallStyle.copyWith(color: mainColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
        );
      },
    );
  }
}
