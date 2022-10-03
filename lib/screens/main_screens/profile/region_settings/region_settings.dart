import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/main_screens/home_layout_screen.dart';
import 'package:hq/screens/main_screens/profile/region_settings/profile_change_branch.dart';
import 'package:hq/screens/main_screens/profile/region_settings/profile_change_city.dart';
import 'package:hq/screens/main_screens/profile/region_settings/profile_change_country.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class RegionSettingsScreen extends StatefulWidget {
  const RegionSettingsScreen({Key? key}) : super(key: key);

  @override
  State<RegionSettingsScreen> createState() => _RegionSettingsScreenState();
}

class _RegionSettingsScreenState extends State<RegionSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: greyExtraLightColor,
          appBar: GeneralAppBar(
            title: LocaleKeys.txtRegionSettings.tr(),
            appBarColor: greyExtraLightColor,
            centerTitle: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSmallSpace,
                textLabel(
                  title: LocaleKeys.txtCountry.tr(),
                ),
                verticalSmallSpace,
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      FadeRoute(
                        page: const ProfileChangeCountryScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(color: greyLightColor, width: 1),
                        color: whiteColor),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/americanFlag.svg',
                            height: 40,
                            width: 60,
                          ),
                          horizontalMiniSpace,
                          Text(
                            '${AppCubit.get(context).countryModel!.data![extraCountryId!].title}',
                            style: titleSmallStyle,
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: greyLightColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                verticalSmallSpace,
                textLabel(
                  title: LocaleKeys.txtCity.tr(),
                ),
                verticalSmallSpace,
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      FadeRoute(
                        page: const ProfileChangeCityScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(color: greyLightColor, width: 1),
                        color: whiteColor),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on, color: greyLightColor),
                          horizontalMiniSpace,
                          Text(
                            '${AppCubit.get(context).cityModel?.data?[extraCityId!].title ?? extraCityTitle}',
                            style: titleSmallStyle,
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: greyLightColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                verticalSmallSpace,
                textLabel(
                  title: LocaleKeys.txtBranch.tr(),
                ),
                verticalSmallSpace,
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        FadeRoute(page: const ProfileChangeBranchScreen()));
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(color: greyLightColor, width: 1),
                        color: whiteColor),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.science_outlined,
                              color: greyLightColor),
                          horizontalMiniSpace,
                          Text(
                            '${AppCubit.get(context).branchModel?.data?[extraBranchId!].title}',
                            style: titleSmallStyle,
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: greyLightColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                verticalSmallSpace,
                textLabel(
                  title: LocaleKeys.languageA.tr(),
                ),
                verticalSmallSpace,
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   FadeRoute(
                    //     page: const ChangeLangScreen(),
                    //   ),
                    // );
                    setState(
                      () async {
                        AppCubit.get(context).changeLanguage();
                        await context
                            .setLocale(Locale(AppCubit.get(context).local!))
                            .then(
                              (value) => {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    FadeRoute(page: const HomeLayoutScreen()),
                                    (route) => false)
                              },
                            );
                      },
                    );
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(color: greyLightColor, width: 1),
                        color: whiteColor),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (sharedLanguage == 'ar')
                            SvgPicture.asset(
                              'assets/images/americanFlag.svg',
                              height: 40,
                              width: 60,
                            ),
                          if (sharedLanguage == 'en')
                            SvgPicture.asset(
                              'assets/images/saudiFlag.svg',
                              height: 40,
                              width: 60,
                            ),
                          horizontalSmallSpace,
                          Text(
                            LocaleKeys.language.tr(),
                            style: titleSmallStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
