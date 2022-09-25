import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/intro_screens/auth/register/select_branch_screen.dart';
import 'package:hq/screens/intro_screens/auth/register/select_city_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class SelectCountryScreen extends StatelessWidget {
  const SelectCountryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
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
                    '${LocaleKeys.BtnSelect.tr()} ${LocaleKeys.txtCountry.tr()}',
                    style: titleStyle.copyWith(fontSize: 30),
                  ),
                  Text(
                    LocaleKeys.onboardingBody.tr(),
                    style: subTitleSmallStyle,
                  ),
                  verticalSmallSpace,
                  LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: greyLightColor.withOpacity(0.3),
                      color: greenColor),
                  verticalLargeSpace,
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            FadeRoute(
                              page: const SelectCityScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              border: Border.all(
                                  color: greyLightColor,
                                  width: 1),
                              color: whiteColor
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.location_on,color: greyLightColor),
                                horizontalMiniSpace,
                                Text(
                                  '${LocaleKeys.txtCountry.tr()}  ${index+1}',
                                  style: titleSmallStyle,
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => verticalSmallSpace,
                      itemCount: 3,
                    ),
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
