import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hq/screens/intro_screens/reset_password/verification_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final mobileController = TextEditingController();
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
                controller: mobileController,
                type: TextInputType.text,
                validatedText: LocaleKeys.txtFieldMobile.tr(),
                label: LocaleKeys.txtFieldMobile.tr(),
                onTap: () {},
              ),
            ),
            verticalMediumSpace,
            GeneralButton(
              title: LocaleKeys.BtnContinue.tr(),
              onPress: () {
                Navigator.push(context, FadeRoute(page: VerificationScreen(isRegister: false, mobileNumber: mobileController.text.toString(),),),);
              },
            ),
            verticalMediumSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.txtHaveProblem.tr(),
                  style: subTitleSmallStyle,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    LocaleKeys.BtnContact.tr(),
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
