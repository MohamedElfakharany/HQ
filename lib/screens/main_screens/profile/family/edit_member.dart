import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/main_screens/profile/edit_profile/change_password.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class EditMemberScreen extends StatefulWidget {
  const EditMemberScreen({Key? key}) : super(key: key);

  @override
  State<EditMemberScreen> createState() => _EditMemberScreenState();
}

class _EditMemberScreenState extends State<EditMemberScreen> {
  var userNameController = TextEditingController();
  var mobileNumberController = TextEditingController();
  var emailController = TextEditingController();
  var maleController = TextEditingController();
  var femaleController = TextEditingController();
  var birthdayController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final _focusNodes =
  Iterable<int>.generate(2).map((_) => FocusNode()).toList();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                  children: [
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: CachedNetworkImage(
                              imageUrl:
                              'https://avatars.githubusercontent.com/u/34916493?s=400&u=e7300b829193270fbcd03a813551a3702299cbb1&v=4',
                              placeholder: (context, url) => const SizedBox(
                                width: 30,
                                height: 30,
                                child:
                                Center(child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                              width: 100,
                              height: 100,
                            ),
                          ),
                          const CircleAvatar(
                            radius: 15.0,
                            backgroundColor: blueColor,
                            child: Icon(
                              Icons.edit,
                              color: whiteColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalMediumSpace,
                    textLabel(title: LocaleKeys.txtFieldName.tr(),),
                    verticalSmallSpace,
                    DefaultFormField(
                      height: 90,
                      focusNode: _focusNodes[0],
                      controller: userNameController,
                      type: TextInputType.text,
                      label:  LocaleKeys.txtFieldName.tr(),
                      onTap: () {},
                    ),
                    verticalSmallSpace,
                    textLabel(title:  LocaleKeys.txtFieldMobile.tr(),),
                    verticalSmallSpace,
                    DefaultFormField(
                      height: 90,
                      focusNode: _focusNodes[1],
                      controller: mobileNumberController,
                      type: TextInputType.number,
                      label: LocaleKeys.txtFieldMobile.tr(),
                      onTap: () {},
                    ),
                    verticalSmallSpace,
                    GeneralButton(
                      title: LocaleKeys.BtnSaveChanges.tr(),
                      onPress: () {
                        Navigator.pop(context);
                      },
                    ),
                    verticalSmallSpace,
                    GeneralButton(
                      title: LocaleKeys.BtnDelete.tr(),
                      btnBackgroundColor: redColor,
                      onPress: () {
                        showPopUp(
                          context,
                          Container(
                            height: 320,
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: Column(
                              children: [
                                verticalSmallSpace,
                                Image.asset(
                                  'assets/images/warning-2.jpg',
                                  width: 50,
                                  height: 50,
                                ),
                                verticalMediumSpace,
                                Text(
                                  LocaleKeys.txtDeleteMain.tr(),
                                  textAlign: TextAlign.center,
                                  style: titleStyle.copyWith(
                                    color: redColor,
                                  ),
                                ),
                                verticalMediumSpace,
                                GeneralButton(
                                  radius: radius,
                                  btnBackgroundColor: redColor,
                                  title: LocaleKeys.txtUnderstandContinue.tr(),
                                  onPress: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                verticalSmallSpace,
                                GeneralButton(
                                  radius: radius,
                                  btnBackgroundColor: greyExtraLightColor,
                                  txtColor: greyDarkColor,
                                  title: LocaleKeys.BtnCancel.tr(),
                                  onPress: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
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
