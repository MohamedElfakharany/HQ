import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/main_screens/home_layout_screen.dart';
import 'package:hq/screens/main_screens/reservations/details_screens/upcoming_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ReservedSuccessScreen extends StatefulWidget {
  const ReservedSuccessScreen({Key? key}) : super(key: key);

  @override
  State<ReservedSuccessScreen> createState() => _ReservedSuccessScreenState();
}

class _ReservedSuccessScreenState extends State<ReservedSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: whiteColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/success.jpg',
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.6,
                  // color: blueColor,
                ),
                Text(
                  LocaleKeys.txtReservationSuccess.tr(),
                  style: titleStyle.copyWith(fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'The Reservation has Successfully, at lab - KSA, Riyadh, Branch King ST 7001 , 20 May, at 4:00 PM',
                    style: subTitleSmallStyle.copyWith(
                      color: greyDarkColor,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                verticalSmallSpace,

                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      FadeRoute(
                        page: const ReservationDetailsUpcomingScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: Center(
                      child: Text(
                        LocaleKeys.txtViewReservation.tr(),
                        style: titleStyle.copyWith(
                            fontSize: 15.0,
                            color: whiteColor,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    AppCubit.get(context).changeBottomScreen(0);
                    navigateAndFinish(context, const HomeLayoutScreen());
                  },
                  child: Text(
                    LocaleKeys.txtBackToHome.tr(),
                    style: titleSmallStyle.copyWith(
                      color: greyDarkColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
