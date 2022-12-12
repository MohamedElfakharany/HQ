import 'package:hq/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/intro_screens/startup/onboarding_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';

class VisitorHolderScreen extends StatefulWidget {
  const VisitorHolderScreen({Key? key}) : super(key: key);

  @override
  State<VisitorHolderScreen> createState() => VisitorHolderScreenState();
}

class VisitorHolderScreenState extends State<VisitorHolderScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: greyExtraLightColor,
          body: Padding(
            padding:
                const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                verticalSmallSpace,
                Image.asset(
                  appLogo,
                  width: 150,
                  height: 150,
                ),
                verticalLargeSpace,
                Text(
                  LocaleKeys.txtPleaseSignInFirst.tr(),
                  style: titleStyle,
                ),
                verticalLargeSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GeneralButton(
                      title: LocaleKeys.BtnSignIn.tr(),
                      onPress: () {
                        AppCubit.get(context).currentIndex = 0;
                        Navigator.pushAndRemoveUntil(
                            context,
                            FadeRoute(
                              page: OnBoardingScreen(),
                            ),
                            (route) => false);
                      }),
                ),
                verticalLargeSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
