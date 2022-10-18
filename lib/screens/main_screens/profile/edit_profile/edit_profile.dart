import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/intro_screens/reset_password/forget_password_screen.dart';
import 'package:hq/screens/main_screens/profile/edit_profile/change_password.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/translations/locale_keys.g.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var userNameController = TextEditingController();
  var idNumberController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var emailController = TextEditingController();
  var birthdayController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final _focusNodes =
      Iterable<int>.generate(6).map((_) => FocusNode()).toList();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
        if (state is AppEditProfileSuccessState) {
          if (state.successModel.status) {
            showToast(msg: LocaleKeys.BtnDone.tr(), state: ToastState.success);
            await AppCubit.get(context).getProfile().then((v) {
              Navigator.pop(context);
            });
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(state.successModel.message),
                  );
                });
          }
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var profileImage = AppCubit.get(context).profileImage;
        Gender gender;
        if (cubit.userResourceModel?.data?.gender == 'Male') {
          gender = Gender.Male;
        } else {
          gender = Gender.Female;
        }
        userNameController.text = cubit.userResourceModel?.data?.name ?? '';
        idNumberController.text =
            cubit.userResourceModel?.data?.nationalId.toString() ?? '';
        mobileNumberController.text =
            cubit.userResourceModel?.data?.phone ?? '';
        emailController.text = cubit.userResourceModel?.data?.email ?? '';
        birthdayController.text = cubit.userResourceModel?.data?.birthday ?? '';
        return Scaffold(
          backgroundColor: greyExtraLightColor,
          appBar: GeneralAppBar(
            title: LocaleKeys.txtEdit.tr(),
            centerTitle: false,
            appBarColor: greyExtraLightColor,
          ),
          body: Padding(
            padding:
                const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
            child: Form(
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
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: profileImage == null
                                ? CachedNetworkImage(
                                    imageUrl: cubit
                                            .userResourceModel?.data?.profile ??
                                        '',
                                    placeholder: (context, url) =>
                                        const SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    width: 100,
                                    height: 100,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(83),
                                    child: Image.file(
                                      profileImage,
                                      height: 140,
                                      width: 140,
                                      fit: BoxFit.cover,
                                    )),
                          ),
                          InkWell(
                            onTap: () {
                              AppCubit.get(context).getProfileImage();
                            },
                            child: const CircleAvatar(
                              radius: 15.0,
                              backgroundColor: blueColor,
                              child: Icon(
                                Icons.edit,
                                color: whiteColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalMediumSpace,
                    textLabel(
                      title: LocaleKeys.txtFieldName.tr(),
                    ),
                    verticalSmallSpace,
                    DefaultFormField(
                      height: 90,
                      focusNode: _focusNodes[0],
                      controller: userNameController,
                      type: TextInputType.text,
                      label: LocaleKeys.txtFieldName.tr(),
                      onTap: () {},
                      validatedText: LocaleKeys.txtFieldName.tr(),
                    ),
                    verticalSmallSpace,
                    textLabel(
                      title: LocaleKeys.txtFieldIdNumber.tr(),
                    ),
                    verticalSmallSpace,
                    DefaultFormField(
                      height: 90,
                      focusNode: _focusNodes[1],
                      controller: idNumberController,
                      type: TextInputType.number,
                      readOnly: true,
                      label: LocaleKeys.txtFieldIdNumber.tr(),
                      onTap: () {},
                      validatedText: LocaleKeys.txtFieldIdNumber.tr(),
                      // obscureText: AppCubit.get(context).idNumberIsPassword,
                      // suffixIcon: AppCubit.get(context).idNumberSufIcon,
                      // suffixPressed: () {
                      //   AppCubit.get(context).idNumberChangeVisibility();
                      // },
                    ),
                    verticalSmallSpace,
                    textLabel(
                      title: LocaleKeys.txtFieldMobile.tr(),
                    ),
                    verticalSmallSpace,
                    DefaultFormField(
                      height: 90,
                      focusNode: _focusNodes[2],
                      controller: mobileNumberController,
                      type: TextInputType.none,
                      readOnly: true,
                      label: LocaleKeys.txtFieldMobile.tr(),
                      onTap: () {},
                      validatedText: LocaleKeys.txtFieldMobile.tr(),
                    ),
                    verticalSmallSpace,
                    textLabel(
                      title: LocaleKeys.txtFieldEmail.tr(),
                    ),
                    verticalSmallSpace,
                    DefaultFormField(
                      height: 90,
                      focusNode: _focusNodes[3],
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: LocaleKeys.txtFieldEmail.tr(),
                      onTap: () {},
                      validatedText: LocaleKeys.txtFieldEmail.tr(),
                    ),
                    verticalSmallSpace,
                    textLabel(
                      title: LocaleKeys.txtFieldDateOfBirth.tr(),
                    ),
                    verticalSmallSpace,
                    DefaultFormField(
                      controller: birthdayController,
                      type: TextInputType.datetime,
                      label: LocaleKeys.txtFieldDateOfBirth.tr(),
                      readOnly: true,
                      validatedText: LocaleKeys.txtFieldDateOfBirth.tr(),
                      onTap: () {
                        showDatePicker(
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          context: context,
                          initialDate: DateTime?.now(),
                          firstDate: DateTime.parse('1950-01-01'),
                          lastDate: DateTime?.now(),
                        ).then((value) {
                          if (value != null) {
                            birthdayController.text =
                                '${value.year}-${value.month}-${value.day}';
                          }
                          DateFormat.yMd().format(value!);
                        }).catchError((error) {
                          if (kDebugMode) {
                            print('error in fetching date');
                            print(error.toString());
                          }
                        });
                      },
                      suffixIcon: Icons.calendar_month,
                    ),
                    verticalSmallSpace,
                    textLabel(
                      title: LocaleKeys.txtFieldGender.tr(),
                    ),
                    verticalSmallSpace,
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
                      isCircular: false,
                      // default : true,
                      opacityOfGradient: 0.3,
                      linearGradient: blueGreenGradient.scale(0.2),
                      padding: const EdgeInsets.all(3),
                      size: 120,
                      selectedGender: gender,
                      //default : 120
                      femaleImage: const AssetImage('assets/images/female.jpg'),
                      maleImage: const AssetImage('assets/images/male.jpg'),
                      onChanged: (Gender? value) {
                        if (value != null) {
                          gender = value;
                          if (kDebugMode) {
                            print(value.index);
                            print(value.name);
                            print(gender.name);
                          }
                        }
                      },
                    ),
                    verticalSmallSpace,
                    ConditionalBuilder(
                      condition: state is! AppEditProfileLoadingState,
                      builder: (context) => GeneralButton(
                        title: LocaleKeys.BtnSaveChanges.tr(),
                        onPress: () {
                          AppCubit.get(context).editProfile(
                              birthday: birthdayController.text,
                              email: emailController.text,
                              gender: gender.name,
                              name: userNameController.text,
                              profile: profileImage == null
                                  ? ''
                                  : 'https://hq.orcav.com/assets/${Uri.file(profileImage.path).pathSegments.last}');
                        },
                      ),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    verticalSmallSpace,
                    GeneralUnfilledButton(
                      title: LocaleKeys.BtnChangePassword.tr(),
                      width: double.infinity,
                      onPress: () {
                        Navigator.push(
                          context,
                          FadeRoute(
                            page: const ChangePasswordScreen(),
                          ),
                        );
                      },
                    ),
                    verticalSmallSpace,
                    GeneralUnfilledButton(
                      title: LocaleKeys.BtnChangeMobile.tr(),
                      width: double.infinity,
                      onPress: () {
                        Navigator.push(
                            context,
                            FadeRoute(
                                page: ForgetPasswordScreen(
                                    isChangeMobile: true)));
                      },
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
