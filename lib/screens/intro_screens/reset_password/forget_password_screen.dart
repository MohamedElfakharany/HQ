// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/intro_screens/reset_password/verification_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key, required this.verificationId})
      : super(key: key);

  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationId = "";

  final mobileController = TextEditingController();
  var formKey = GlobalKey<FormState>();

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
        verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
      },
    );

    if (kDebugMode) {
      print('verificationId Sign In : ${verificationId}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
        if (state is AppCreateTokenSuccessState) {
          if (state.createTokenModel.status) {
            fetchOtp(number: mobileController.text.toString());
            await Navigator.push(
              context,
              FadeRoute(
                page: VerificationScreen(
                  resetToken: state.createTokenModel.data!.resetToken,
                  isRegister: false,
                  verificationId: verificationId,
                  mobileNumber: mobileController.text.toString(),
                ),
              ),
            );
          } else {}
        } else {}
      },
      builder: (context, state) => Scaffold(
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
                    LocaleKeys.forgetTxtMain.tr(),
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
                    LocaleKeys.resetEnterMobile.tr(),
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
                  controller: mobileController,
                  type: TextInputType.phone,
                  validatedText: LocaleKeys.txtFieldMobile.tr(),
                  label: LocaleKeys.txtFieldMobile.tr(),
                  onTap: () {},
                ),
              ),
              verticalMediumSpace,
              ConditionalBuilder(
                condition: state is! AppCreateTokenLoadingState,
                builder: (context) => GeneralButton(
                  title: LocaleKeys.BtnContinue.tr(),
                  onPress: () {
                    if (formKey.currentState!.validate()) {
                      AppCubit.get(context).createToken(mobile: mobileController.text);
                    }
                  },
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              // verticalMediumSpace,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       LocaleKeys.txtHaveProblem.tr(),
              //       style: subTitleSmallStyle,
              //     ),
              //     ConditionalBuilder(
              //       condition: true,
              //       builder: (context) => TextButton(
              //         onPressed: () {},
              //         child: Text(
              //           LocaleKeys.BtnContact.tr(),
              //           style: titleSmallStyle.copyWith(color: blueColor),
              //         ),
              //       ),
              //       fallback: (context) => const Center(
              //         child: CircularProgressIndicator(),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
