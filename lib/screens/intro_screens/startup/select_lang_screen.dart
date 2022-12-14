// ignore_for_file: use_build_context_synchronously

import 'package:hq/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/intro_screens/startup/onboarding_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/cache_helper.dart';
import 'package:hq/shared/network/local/const_shared.dart';

class SelectLangScreen extends StatefulWidget {
  const SelectLangScreen({Key? key}) : super(key: key);

  @override
  State<SelectLangScreen> createState() => _SelectLangScreenState();
}

bool isEnglish = true;

class _SelectLangScreenState extends State<SelectLangScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: whiteColor,
            elevation: 0.0,
          ),
          body: Container(
            color: whiteColor,
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    appLogo,
                    width: 150,
                    height: 150,
                  ),
                  verticalLargeSpace,
                  InkWell(
                    onTap: () {
                      if (sharedLanguage == 'en') {
                        CacheHelper.saveData(key: 'isEnglish', value: true);
                        AppCubit.get(context).changeLanguage();
                        context.setLocale(Locale(sharedLanguage!));
                      } else if (sharedLanguage == 'ar') {
                        CacheHelper.saveData(key: 'isEnglish', value: false);
                        context.setLocale(Locale(sharedLanguage!));
                      } else {
                        context.setLocale(const Locale('ar'));
                        CacheHelper.saveData(key: 'isEnglish', value: false);
                        CacheHelper.saveData(key: 'local', value: 'ar');
                      }
                      isEnglish = false;
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(
                            color: isEnglish ? greyLightColor : greenColor,
                            width: 1),
                        color: isEnglish
                            ? whiteColor
                            : greenColor.withOpacity(0.16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/saudiFlag.svg',
                              height: 40,
                              width: 60,
                            ),
                            horizontalMiniSpace,
                            Text(
                              '?????????? ??????????????',
                              style: titleSmallStyle,
                            ),
                            const Spacer(),
                            if (!isEnglish)
                              SvgPicture.asset(
                                'assets/images/checkTrue.svg',
                                height: 25,
                                width: 25,
                              ),
                            horizontalMicroSpace,
                          ],
                        ),
                      ),
                    ),
                  ),
                  verticalSmallSpace,
                  InkWell(
                    onTap: () {
                      if (sharedLanguage == 'ar') {
                        CacheHelper.saveData(key: 'isEnglish', value: false);
                        AppCubit.get(context).changeLanguage();
                        context.setLocale(Locale(sharedLanguage!));
                      } else if (sharedLanguage == 'en') {
                        CacheHelper.saveData(key: 'isEnglish', value: true);
                        context.setLocale(Locale(sharedLanguage!));
                      } else {
                        context.setLocale(const Locale('en'));
                        CacheHelper.saveData(key: 'isEnglish', value: true);
                        setState(() async {
                          CacheHelper.saveData(key: 'local', value: 'en');
                        });
                      }
                      isEnglish = true;
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(
                            color: isEnglish ? greenColor : greyLightColor,
                            width: 1),
                        color: isEnglish
                            ? greenColor.withOpacity(0.16)
                            : whiteColor,
                      ),
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
                              'English',
                              style: titleSmallStyle,
                            ),
                            const Spacer(),
                            if (isEnglish)
                              SvgPicture.asset(
                                'assets/images/checkTrue.svg',
                                height: 25,
                                width: 25,
                              ),
                            horizontalMicroSpace,
                          ],
                        ),
                      ),
                    ),
                  ),
                  verticalLargeSpace,
                  GeneralButton(
                      title: LocaleKeys.BtnContinue.tr(),
                      onPress: () {
                        isFirst = false;
                        CacheHelper.saveData(key: 'isFirst', value: false);
                        CacheHelper.saveData(
                            key: 'isEnglish', value: isEnglish);
                        Navigator.push(
                          context,
                          FadeRoute(
                            page: OnBoardingScreen(),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
