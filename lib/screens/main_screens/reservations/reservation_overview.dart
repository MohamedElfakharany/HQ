import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hq/screens/main_screens/reservations/reserved_success_screen.dart';
import 'package:hq/shared/components/cached_network_image.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ReservationOverviewScreen extends StatefulWidget {
  const ReservationOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ReservationOverviewScreen> createState() =>
      _ReservationOverviewScreenState();
}

class _ReservationOverviewScreenState extends State<ReservationOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyExtraLightColor,
      appBar: GeneralAppBar(
        title: LocaleKeys.txtOverview.tr(),
        centerTitle: false,
        appBarColor: greyExtraLightColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Review your test',
              style: titleStyle.copyWith(fontWeight: FontWeight.w500),
            ),
            verticalSmallSpace,
            Container(
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
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
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
                          children: [
                            const Text(
                              'Glaciated Hemoglobin HBA1C',
                              style: titleSmallStyle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Text(
                              'Sugar Test category',
                              style: subTitleSmallStyle2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '80 ${LocaleKeys.salary.tr()}',
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
            MaterialButton(
              onPressed: () {
                navigateAndFinish(
                  context,
                  const ReservedSuccessScreen(),
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
                    LocaleKeys.BtnConfirm.tr(),
                    style: titleStyle.copyWith(
                      fontSize: 20.0,
                      color: whiteColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
