import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/intro_screens/auth/register/sign_up_screen.dart';
import 'package:hq/screens/intro_screens/reset_password/forget_password_screen.dart';
import 'package:hq/screens/main_screens/home_layout_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final _focusNodes =
      Iterable<int>.generate(2).map((_) => FocusNode()).toList();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
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
                      controller: userNameController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (formKey.currentState!.validate()) {
                          if (value!.isEmpty) {
                            return LocaleKeys.txtFieldMobile.tr();
                          }
                        }
                      },
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
                      validate: (value) {
                        if (formKey.currentState!.validate()) {
                          if (value!.isEmpty) {
                            return LocaleKeys.txtFieldPassword.tr();
                          }
                        }
                      },
                      obscureText: AppCubit.get(context).loginIsPassword,
                      suffixIcon: AppCubit.get(context).loginSufIcon,
                      label: LocaleKeys.txtFieldPassword.tr(),
                      suffixPressed: () {
                        AppCubit.get(context).loginChangePasswordVisibility();
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
                  GeneralButton(
                    title: LocaleKeys.BtnSignIn.tr(),
                    onPress: () {
                      AppCubit.get(context).isVisitor = false;
                      Navigator.pushAndRemoveUntil(
                          context,
                          FadeRoute(page: const HomeLayoutScreen()),
                          (route) => false);
                    },
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
