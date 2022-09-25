import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hq/screens/intro_screens/reset_password/reset_password_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/translations/locale_keys.g.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final codeController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: GeneralAppBar(title: '',),
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
                type: TextInputType.text,
                validate: (value){
                  if (formKey.currentState!.validate()){
                    if (value!.isEmpty){
                      return LocaleKeys.txtFieldCodeReset.tr();
                    }
                  }
                },
                label: LocaleKeys.txtFieldCodeReset.tr(),
                onTap: () {},
              ),
            ),
            verticalMediumSpace,
            GeneralButton(
              title: LocaleKeys.BtnVerify.tr(),
              onPress: () {
                Navigator.push(context, FadeRoute(page: const ResetPasswordScreen(),),);
              },
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
                  onPressed: () {},
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
  }
}
