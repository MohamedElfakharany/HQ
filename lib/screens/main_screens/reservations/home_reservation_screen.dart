import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hq/screens/main_screens/reservations/details_screens/reservation_details.dart';
import 'package:hq/screens/main_screens/widgets_components/widgets_components.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class HomeReservationScreen extends StatefulWidget {
  const HomeReservationScreen({Key? key}) : super(key: key);

  @override
  State<HomeReservationScreen> createState() => _HomeReservationScreenState();
}

class _HomeReservationScreenState extends State<HomeReservationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyExtraLightColor,
      appBar: GeneralAppBar(
        title: LocaleKeys.txtHomeReservation.tr(),
        centerTitle: false,
        appBarColor: greyExtraLightColor,
      ),
      body: Column(
        children: [
          const HomeCalenderView(),
          verticalSmallSpace,
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    FadeRoute(
                      page: const ReservationDetailsScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    height: 95,
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        border: Border.all(color: blueColor),
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Morning Period',
                            style: TextStyle(
                              color: blueColor,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          verticalMicroSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    LocaleKeys.txtStartAt.tr(),
                                    style: titleSmallStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Text(
                                    '08:00 Am',
                                    style: subTitleSmallStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    LocaleKeys.txtEndAt.tr(),
                                    style: titleSmallStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Text(
                                    '02:00 Pm',
                                    style: subTitleSmallStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => verticalSmallSpace,
              itemCount: 2,
            ),
          ),
        ],
      ),
    );
  }
}
