// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
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

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({Key? key, required this.verificationId})
      : super(key: key);

  String verificationId = "";

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final mobileController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppCreateTokenSuccessState) {
          if (state.createTokenModel.status) {
            Navigator.push(
              context,
              FadeRoute(
                page: VerificationScreen(
                  resetToken: state.createTokenModel.data!.resetToken,
                  isRegister: false,
                  verificationId: widget.verificationId,
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
                  controller: mobileController,
                  type: TextInputType.text,
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
              verticalMediumSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.txtHaveProblem.tr(),
                    style: subTitleSmallStyle,
                  ),
                  ConditionalBuilder(
                    condition: true,
                    builder: (context) => TextButton(
                      onPressed: () {},
                      child: Text(
                        LocaleKeys.BtnContact.tr(),
                        style: titleSmallStyle.copyWith(color: blueColor),
                      ),
                    ),
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
