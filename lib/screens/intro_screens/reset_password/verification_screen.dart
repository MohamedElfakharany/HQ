// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/intro_screens/auth/register/select_country_screen.dart';
import 'package:hq/screens/intro_screens/reset_password/reset_password_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/translations/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({
    Key? key,
    required this.mobileNumber,
    this.verificationId,
    this.resetToken,
    this.isRegister,
  }) : super(key: key);
  bool? isRegister;
  String? verificationId = "";
  String mobileNumber = "";
  String? resetToken = "";

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final codeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> fetchOtp({required String number}) async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+2$number',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((v) => {

        });
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          if (kDebugMode) {
            print('The provided phone number is not valid.');
          }
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        widget.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    if (kDebugMode) {
      print('verificationId Sign In : ${widget.verificationId}');
    }
  }

  Future<void> verify() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId.toString(),
      smsCode: codeController.text,
    );
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        if (widget.isRegister == true) {
          await AppCubit.get(context).verify();
        } else {
          Navigator.push(
            context,
            FadeRoute(
              page: ResetPasswordScreen(resetToken: widget.resetToken),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.code.toLocale(separator: AppCubit.get(context).local!));
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.code.toLocale(separator: AppCubit.get(context).local!).toString()),
          );
        },
      );
      if (kDebugMode) {
        print("catch");
      }
    }
  }

  saveVerified({required String verified1}) async {
    (await SharedPreferences.getInstance()).setString('verified', verified1);
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(widget.mobileNumber.toString());
      print(widget.verificationId);
    }
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppGetVerifySuccessState) {
          if (state.successModel.status) {
            saveVerified(verified1: '1');
            AppCubit.get(context).getCountry().then((value) => {
                  Navigator.push(
                    context,
                    FadeRoute(
                      page: const SelectCountryScreen(),
                    ),
                  ),
                });
          }
        }
      },
      builder: (context, state) {
        // fetchOtp(number: widget.mobileNumber);
        return Scaffold(
          backgroundColor: whiteColor,
          appBar: GeneralAppBar(
            title: '',
          ),
          body: Form(
            key: formKey,
            child: ListView(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      LocaleKeys.verifyTxtMain.tr(),
                      style: titleStyle.copyWith(
                          fontSize: 30.0, fontWeight: FontWeight.w600),
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
                          fontWeight: FontWeight.normal, color: greyLightColor),
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
                  condition: state is! AppGetVerifyLoadingState,
                  builder: (context) => GeneralButton(
                    title: LocaleKeys.BtnVerify.tr(),
                    onPress: () {
                      if (formKey.currentState!.validate()) {
                        verify();
                      }
                    },
                  ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
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
                        fetchOtp(number: widget.mobileNumber);
                      },
                      child: Text(
                        LocaleKeys.BtnResend.tr(),
                        style: titleSmallStyle.copyWith(color: blueColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
