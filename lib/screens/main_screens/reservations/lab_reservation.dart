import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hq/screens/main_screens/reservations/details_screens/reservation_details.dart';
import 'package:hq/screens/main_screens/widgets_components/widgets_components.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class LabReservationScreen extends StatefulWidget {
  const LabReservationScreen({Key? key}) : super(key: key);

  @override
  State<LabReservationScreen> createState() => _LabReservationScreenState();
}

class _LabReservationScreenState extends State<LabReservationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyExtraLightColor,
      appBar: GeneralAppBar(
        title: LocaleKeys.txtLabReservation.tr(),
        centerTitle: false,
        appBarColor: greyExtraLightColor,
      ),
      body: Column(
        children: [
          const LabCalenderView(),
          verticalSmallSpace,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GridView.count(
                // shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 3 / 1,
                children: List.generate(
                  40,
                      (index) => InkWell(
                    onTap: () {
                      Navigator.push(context, FadeRoute(page: const ReservationDetailsScreen(),),);
                    },
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      alignment: AlignmentDirectional.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 4),
                      child: const Text(
                        textAlign: TextAlign.center,
                        '1:30 PM',
                        style: titleSmallStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
