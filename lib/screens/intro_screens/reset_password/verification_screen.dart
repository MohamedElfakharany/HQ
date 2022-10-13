// ignore_for_file: must_be_immutable

import 'dart:async';
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
    this.isRegister,
  }) : super(key: key);
  bool? isRegister;
  String mobileNumber = "";

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final codeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isFirst = true;
  String? resetToken;

  Future<void> verify() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: AppCubit.get(context).verificationId.toString(),
      smsCode: codeController.text,
    );
    print('AppCubit.get(context).verificationId.toString() : $AppCubit.get(context).verificationId.toString()');
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await AppCubit.get(context).auth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        if (widget.isRegister == true) {
          await AppCubit.get(context).verify().then((v) {
            AppCubit.get(context).getCountry().then((v){
            Navigator.push(context,FadeRoute(page: const SelectCountryScreen()));
            });
          });
        } else {
          Navigator.push(
            context,
            FadeRoute(
              page: ResetPasswordScreen(resetToken: resetToken),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code.toLocale(separator: AppCubit.get(context).local!));
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              e.code
                  .toLocale(separator: AppCubit.get(context).local!)
                  .toString(),
            ),
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
  void initState() {
    super.initState();
    if (isFirst) {
      isFirst = false;
      AppCubit.get(context).fetchOtp(number: widget.mobileNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(widget.mobileNumber.toString());
      print('AppCubit.get(context).verificationId : $AppCubit.get(context).verificationId');
    }
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
        if (state is AppGetVerifySuccessState) {
          if (state.successModel.status) {
            saveVerified(verified1: '1');
            AppCubit.get(context).getCountry().then(
                  (value) => {
                    Navigator.push(
                      context,
                      FadeRoute(
                        page: const SelectCountryScreen(),
                      ),
                    ),
                  },
                );
          }
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
                    condition: state is! AppGetVerifyLoadingState ||
                        state is! AppCreateTokenLoadingState || AppCubit.get(context).verificationId != null,
                    builder: (context) => GeneralButton(
                      title: LocaleKeys.BtnVerify.tr(),
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          AppCubit.get(context)
                              .createToken(
                                  mobile: widget.mobileNumber.toString())
                              .then((v) {
                            verify();
                          });
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
                          AppCubit.get(context)
                              .createToken(
                                  mobile: widget.mobileNumber.toString())
                              .then((v) {
                            AppCubit.get(context).fetchOtp(number: widget.mobileNumber);
                          });
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
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
