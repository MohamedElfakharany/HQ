import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/main_screens/home_layout_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class SelectGenderScreen extends StatelessWidget {
  const SelectGenderScreen({Key? key, required this.countryId, required this.cityId, required this.branchId}) : super(key: key);
  final int countryId;
  final int cityId;
  final int branchId;

  @override
  Widget build(BuildContext context) {
    String selectedGender = LocaleKeys.Male.tr();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppCompleteProfileSuccessState) {
          if (state.userResourceModel.status) {
            navigateAndFinish(context,const HomeLayoutScreen());
          }
        }
        if (AppCubit.get(context).isVisitor == true ){
          navigateAndFinish(context,const HomeLayoutScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: GeneralAppBar(title: ''),
          body: Container(
            color: whiteColor,
            child: Padding(
              padding:
              const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
              child: Column(
                children: [
                  verticalSmallSpace,
                  Text(
                    '${LocaleKeys.BtnSelect.tr()} ${LocaleKeys.txtFieldGender
                        .tr()}',
                    style: titleStyle.copyWith(fontSize: 30),
                  ),
                  Text(
                    LocaleKeys.onboardingBody.tr(),
                    style: subTitleSmallStyle,
                  ),
                  verticalSmallSpace,
                  LinearProgressIndicator(
                      value: 0.9,
                      backgroundColor: greyLightColor.withOpacity(0.3),
                      color: greenColor),
                  verticalLargeSpace,
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
                    linearGradient: blueGreenGradient.scale(0.3),
                    padding: const EdgeInsets.all(3),
                    size: 120,
                    //default : 120
                    femaleImage: const AssetImage('assets/images/female.jpg'),
                    maleImage: const AssetImage('assets/images/male.jpg'),

                    onChanged: (Gender? value) {
                      if (value != null) {
                        selectedGender = value.name ;
                        if (kDebugMode) {
                          print(value.index);
                          print(value.name);
                          print(selectedGender);
                        }
                      }
                    },
                  ),
                  verticalSmallSpace,
                  ConditionalBuilder(
                    condition: state is! AppCompleteProfileLoadingState,
                    builder: (context) =>
                        GeneralButton(title: 'start', onPress: () {
                          extraCountryId = countryId;
                          extraCityId = cityId;
                          extraBranchId = branchId;
                          AppCubit.get(context).completeProfile(
                            countryId: countryId,
                            cityId: cityId,
                            branchId: branchId,
                            gender: selectedGender,);
                        }),
                    fallback: (context) =>
                    const Center(child: CircularProgressIndicator(),),
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
