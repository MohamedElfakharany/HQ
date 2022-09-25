import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/main_screens/home_layout_screen.dart';
import 'package:hq/screens/main_screens/reservations/details_screens/rate_screens/experience_rate_screen.dart';
import 'package:hq/shared/components/cached_network_image.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ReservationDetailsUpcomingScreen extends StatefulWidget {
  const ReservationDetailsUpcomingScreen({Key? key}) : super(key: key);

  @override
  State<ReservationDetailsUpcomingScreen> createState() =>
      _ReservationDetailsUpcomingScreenState();
}

class _ReservationDetailsUpcomingScreenState
    extends State<ReservationDetailsUpcomingScreen> {

  @override
  void initState(){
    super.initState();
    if (kDebugMode) {
      print('object');
    }
    Timer(
      const Duration(milliseconds: 1000),
          () {
        if (kDebugMode) {
          print('object');
        }
        showCustomBottomSheet(context,
                bottomSheetContent: const ExperienceRateScreen(),
                bottomSheetHeight: 0.65);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: greyExtraLightColor,
          appBar: GeneralAppBar(
            title: LocaleKeys.txtReservationDetails.tr(),
            centerTitle: false,
            appBarColor: greyExtraLightColor,
            leading: IconButton(
              onPressed: () {
                AppCubit.get(context).changeBottomScreen(2);
                navigateAndFinish(context, const HomeLayoutScreen());
              },
              icon: const Icon(
                Icons.arrow_back,
                color: greyDarkColor,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(width: 1, color: greyLightColor),
                  ),
                  alignment: AlignmentDirectional.center,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '#150-450-600',
                        ),
                        const Spacer(),
                        Container(
                          height: 36,
                          decoration: BoxDecoration(
                            color: blueLightColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(radius),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                              child: Text(
                                  LocaleKeys.txtUpcoming.tr(),
                                style: titleStyle.copyWith(
                                    fontSize: 15.0,
                                    color: blueColor,
                                    fontWeight: FontWeight.normal),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                verticalMediumSpace,
                Text(
                  '${LocaleKeys.homeTxtTestLibrary.tr()} (03)',
                  style: titleStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                verticalSmallSpace,
                SizedBox(
                  height: 180,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => Container(
                      height: 110.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(
                          width: 1,
                          color: greyLightColor,
                        ),
                      ),
                      alignment: AlignmentDirectional.center,
                      padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Row(
                            children: [
                              horizontalMicroSpace,
                              CachedNetworkImageNormal(
                                imageUrl: imageTest,
                                width: 80,
                                height: 80,
                              ),
                              horizontalSmallSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Glaciated Hemoglobin HBA1C',
                                      style: titleSmallStyle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Sugar Test category',
                                      style: subTitleSmallStyle2,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '80 SAR',
                                      style: titleSmallStyle2,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => verticalMiniSpace,
                    itemCount: 3,
                  ),
                ),
                verticalMiniSpace,
                Text(
                  LocaleKeys.txtReservationDetails.tr(),
                  style: titleStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                verticalMiniSpace,
                Container(
                  height: 250.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  alignment: AlignmentDirectional.center,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            horizontalSmallSpace,
                            Image.asset(
                              'assets/images/profile.png',
                              width: 25,
                              height: 35,
                              color: blueColor,
                            ),
                            myVerticalDivider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.txtPatient.tr(),
                                  style: titleStyle.copyWith(color: greyLightColor),
                                ),
                                const Text(
                                  textAlign: TextAlign.start,
                                  'Mohamed Elfakharany',
                                  style: titleSmallStyle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            horizontalSmallSpace,
                            Image.asset(
                              'assets/images/profile.png',
                              width: 25,
                              height: 35,
                              color: blueColor,
                            ),
                            myVerticalDivider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.txtReservationDetails.tr(),
                                  style: titleStyle.copyWith(color: greyLightColor),
                                ),
                                const Text(
                                  textAlign: TextAlign.start,
                                  'In Lab - KSA, Riyadh , King St 7034',
                                  style: subTitleSmallStyle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            horizontalSmallSpace,
                            Image.asset(
                              'assets/images/profile.png',
                              width: 25,
                              height: 35,
                              color: blueColor,
                            ),
                            myVerticalDivider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.AppointmentScreenTxtTitle.tr(),
                                  style: titleStyle.copyWith(color: greyLightColor),
                                ),
                                const Text(
                                  textAlign: TextAlign.start,
                                  '24 Feb 2022 - 5:30 PM',
                                  style: titleSmallStyle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                verticalMiniSpace,
                Container(
                  height: 250.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  alignment: AlignmentDirectional.center,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSmallSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          LocaleKeys.txtSummary.tr(),
                          style: titleSmallStyle.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      myHorizontalDivider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.txtItems.tr(),
                                  style: titleSmallStyle.copyWith(
                                      color: greyDarkColor,
                                      fontWeight: FontWeight.normal),
                                ),
                                const Spacer(),
                                const Text(
                                  textAlign: TextAlign.start,
                                  '03',
                                  style: titleSmallStyle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            verticalMicroSpace,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.txtPrice.tr(),
                                  style: titleSmallStyle.copyWith(
                                      color: greyDarkColor,
                                      fontWeight: FontWeight.normal),
                                ),
                                const Spacer(),
                                Text(
                                  textAlign: TextAlign.start,
                                  '330 ${LocaleKeys.salary.tr()}',
                                  style: titleSmallStyle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            verticalMicroSpace,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.txtVAT.tr(),
                                  style: titleSmallStyle.copyWith(
                                      color: greyDarkColor,
                                      fontWeight: FontWeight.normal),
                                ),
                                const Spacer(),
                                const Text(
                                  textAlign: TextAlign.start,
                                  '15%',
                                  style: titleSmallStyle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            verticalMicroSpace,
                            const MySeparator(),
                            verticalMicroSpace,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  LocaleKeys.txtTotal.tr(),
                                  style: titleSmallStyle.copyWith(
                                      color: greyDarkColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Text(
                                  textAlign: TextAlign.start,
                                  '379.5 ${LocaleKeys.salary.tr()}',
                                  style: titleSmallStyle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  LocaleKeys.txtAddedTax.tr(),
                                  textAlign: TextAlign.start,
                                  style: titleSmallStyle.copyWith(
                                      color: greyDarkColor,
                                      fontWeight: FontWeight.normal),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSmallSpace,
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          showPopUp(
                            context,
                            Container(
                              height: 400,
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
                                    LocaleKeys.txtPopUpMainCancelReservation.tr(),
                                    textAlign: TextAlign.center,
                                    style: titleStyle.copyWith(
                                      color: redColor,
                                    ),
                                  ),
                                  verticalMediumSpace,
                                  Text(
                                    LocaleKeys.txtPopUpSecondaryCancelReservation.tr(),
                                    textAlign: TextAlign.center,
                                    style: subTitleSmallStyle,
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
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(radius),
                          ),
                          child: Center(
                              child: Text(
                                LocaleKeys.BtnCancel.tr(),
                                style: titleStyle.copyWith(
                                    fontSize: 20.0,
                                    color: whiteColor,
                                    fontWeight: FontWeight.normal),
                              )),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.wifi_calling_3,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
