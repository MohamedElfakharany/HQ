import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/translations/locale_keys.g.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../../../../cubit/states.dart';

class NewMemberScreen extends StatefulWidget {
  const NewMemberScreen({Key? key}) : super(key: key);

  @override
  State<NewMemberScreen> createState() => _NewMemberScreenState();
}

class _NewMemberScreenState extends State<NewMemberScreen> {
  var userNameController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var birthdayController = TextEditingController();
  final genderItems = [
    'Father',
    'Mother',
    'Wife',
    'son',
    'daughter',
    'other',
  ];
  String? genderValue;
  var formKey = GlobalKey<FormState>();
  final _focusNodes =
      Iterable<int>.generate(4).map((_) => FocusNode()).toList();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: greyExtraLightColor,
          appBar: GeneralAppBar(
            title: LocaleKeys.txtNewMember.tr(),
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
                  children: [
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
                    verticalSmallSpace,
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
                      title: LocaleKeys.txtFieldDateOfBirth.tr(),
                    ),
                    verticalSmallSpace,
                    DefaultFormField(
                      controller: birthdayController,
                      focusNode: _focusNodes[1],
                      type: TextInputType.datetime,
                      label: LocaleKeys.txtFieldDateOfBirth.tr(),
                      validatedText: LocaleKeys.txtFieldDateOfBirth.tr(),
                      readOnly: true,
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
                          //     DateFormat.yMd().format(value!);
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
                      title: LocaleKeys.txtRelationship.tr(),
                    ),
                    verticalSmallSpace,
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null) {
                            return LocaleKeys.txtRelationship.tr();
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsetsDirectional.only(
                              start: 20.0, end: 10.0),
                          fillColor: Colors.white,
                          filled: true,
                          errorStyle: const TextStyle(color: Color(0xFF4F4F4F)),
                          label: Text(
                            LocaleKeys.txtRelationship.tr(),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: blueColor,
                            ),
                          ),
                        ),
                        value: AppCubit.get(context).relationsModel!.data!.first.title ?? '',
                        isExpanded: true,
                        iconSize: 35,
                        items: AppCubit.get(context).relationsName.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => genderValue = value),
                        onSaved: (v) {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                    verticalSmallSpace,
                    textLabel(
                      title: LocaleKeys.txtFieldMobile.tr(),
                    ),
                    verticalSmallSpace,
                    DefaultFormField(
                      height: 90,
                      focusNode: _focusNodes[3],
                      controller: mobileNumberController,
                      type: TextInputType.number,
                      label: LocaleKeys.txtFieldMobile.tr(),
                      onTap: () {},
                      validatedText: LocaleKeys.txtFieldDateOfBirth.tr(),
                    ),
                    verticalMediumSpace,
                    GeneralButton(
                      title: LocaleKeys.BtnSaveChanges.tr(),
                      onPress: () {
                        Navigator.pop(context);
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}
