import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/intro_screens/auth/login_screen.dart';
import 'package:hq/screens/intro_screens/auth/register/select_country_screen.dart';
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
  final idNumberController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final _focusNodes =
      Iterable<int>.generate(4).map((_) => FocusNode()).toList();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
                        validate: (value) {
                          if (formKey.currentState!.validate()) {
                            if (value!.isEmpty) {
                              return LocaleKeys.txtFieldName.tr();
                            }
                          }
                        },
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
                        focusNode: _focusNodes[2],
                        controller: passwordController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (formKey.currentState!.validate()) {
                            if (value!.isEmpty) {
                              return LocaleKeys.txtFieldPassword.tr();
                            }
                          }
                        },
                        obscureText: AppCubit.get(context).signUpIsPassword,
                        suffixIcon: AppCubit.get(context).signUpSufIcon,
                        label: LocaleKeys.txtFieldPassword.tr(),
                        suffixPressed: () {
                          AppCubit.get(context)
                              .signUpChangePasswordVisibility();
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
                        controller: idNumberController,
                        type: TextInputType.number,
                        label: LocaleKeys.txtFieldIdNumber.tr(),
                        onTap: () {},
                        validate: (value) {
                          if (formKey.currentState!.validate()) {
                            if (value!.isEmpty) {
                              return LocaleKeys.txtFieldIdNumber.tr();
                            }
                          }
                        },
                      ),
                    ),
                    GenderPickerWithImage(
                      maleText: LocaleKeys.Male.tr(),
                      //default Male
                      femaleText: LocaleKeys.Female.tr(),
                      //default Female
                      selectedGenderTextStyle:
                          titleStyle.copyWith(color: greenColor),
                      verticalAlignedText: true,
                      equallyAligned: true,
                      animationDuration: const Duration(milliseconds: 300),
                      isCircular: true,
                      // default : true,
                      opacityOfGradient: 0.3,
                      linearGradient: blueGreenGradient.scale(0.2),
                      padding: const EdgeInsets.all(3),
                      size: 120,
                      //default : 120
                      femaleImage: const AssetImage('assets/images/female.jpg'),
                      maleImage: const AssetImage('assets/images/male.jpg'),
                      onChanged: (Gender? value) {
                        if (value != null) {
                          if (kDebugMode) {
                            print(value.index);
                          }
                        }
                      },
                    ),
                    // verticalMiniSpace,
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
                                                LocaleKeys.txtTitleOfOurTermsOfService.tr(),
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
                                                    LocaleKeys.onboardingBody.tr(),
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
                                                LocaleKeys.txtTitleOfOurPrivacyPolicy.tr(),
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
                                                    LocaleKeys.onboardingBody.tr(),
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
                    GeneralButton(
                      title: LocaleKeys.BtnSignUp.tr(),
                      onPress: () {
                        AppCubit.get(context).isVisitor = false;
                        Navigator.push(
                          context,
                          FadeRoute(
                            page: const SelectCountryScreen(),
                          ),
                        );
                      },
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
