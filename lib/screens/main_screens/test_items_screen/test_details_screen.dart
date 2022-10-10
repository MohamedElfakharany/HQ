// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/models/test_models/offers_model.dart';
import 'package:hq/models/test_models/tests_model.dart';
import 'package:hq/screens/main_screens/card_screen.dart';
import 'package:hq/screens/main_screens/home_layout_screen.dart';
import 'package:hq/screens/main_screens/reservations/home_reservation_screen.dart';
import 'package:hq/screens/main_screens/reservations/lab_reservation.dart';
import 'package:hq/screens/main_screens/test_items_screen/read_more_screen.dart';
import 'package:hq/screens/main_screens/widgets_components/widgets_components.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class TestDetailsScreen extends StatelessWidget {
  TestDetailsScreen({Key? key,this.offersDataModel, this.testsDataModel}) : super(key: key);
  TestsDataModel? testsDataModel;
  OffersDataModel? offersDataModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: GeneralAppBar(title: LocaleKeys.txtTestDetails.tr()),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: ListView(
          children: [
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                CachedNetworkImage(
                  imageUrl: testsDataModel?.image ?? offersDataModel?.image,
                  fit: BoxFit.cover,
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        child: const Center(
                          child: Text(
                            '%',
                            style: TextStyle(color: whiteColor,fontSize: 20),
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (offersDataModel?.gender == 'Male' || testsDataModel?.gender == 'Male')
                        Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            color: blueLightColor,
                            borderRadius: BorderRadius.circular(radius),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  offersDataModel?.gender ?? testsDataModel?.gender,
                                  style: const TextStyle(color: whiteColor),
                                ),
                                horizontalMicroSpace,
                                const Icon(
                                  Icons.male,
                                  color: whiteColor,
                                )
                              ],
                            ),
                          ),
                        )
                      else if (offersDataModel?.gender == 'Female' || testsDataModel?.gender == 'Male')
                        Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            color: pinkColor,
                            borderRadius: BorderRadius.circular(radius),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  offersDataModel?.gender,
                                  style: const TextStyle(color: whiteColor),
                                ),
                                const Icon(
                                  Icons.female,
                                  color: whiteColor,
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
              child: Text(
                testsDataModel?.title ?? offersDataModel?.title,
                style: titleSmallStyle2,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Text(
                    '${testsDataModel?.price ?? offersDataModel?.discount} ${LocaleKeys.salary.tr()}',
                    style: titleStyle,
                  ),
                  horizontalMiniSpace,
                  if(offersDataModel != null)
                  Text(
                    '${offersDataModel?.price} ${LocaleKeys.salary.tr()}',
                    style: subTitleSmallStyle.copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  horizontalMiniSpace,
                ],
              ),
            ),
            Text(
              testsDataModel?.description ?? offersDataModel?.description,
              style: subTitleSmallStyle.copyWith(
                fontSize: 15,
              ),
            ),
            verticalMediumSpace,
            Container(
              height: 110.0,
              width: 110.0,
              decoration: BoxDecoration(
                color: greyExtraLightColor,
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(
                  width: 1,
                  color: greyDarkColor,
                ),
              ),
              alignment: AlignmentDirectional.center,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 10.0, top: 10.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  horizontalMiniSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalMiniSpace,
                        Text(
                          LocaleKeys.txtAnalysisPreparations.tr(),
                          style: titleSmallStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          testsDataModel?.preparation ?? offersDataModel?.preparation,
                          style: const TextStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              FadeRoute(
                                page: ReadMoreScreen(testsDataModel: testsDataModel,offersDataModel: offersDataModel,)),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                LocaleKeys.BtnMore.tr(),
                                style: titleSmallStyle.copyWith(
                                    color: blueColor,
                                    fontWeight: FontWeight.normal),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: blueColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            verticalMediumSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    if (AppCubit.get(context).isVisitor == false) {
                      showCustomBottomSheet(
                        context,
                        bottomSheetContent: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radius),
                              topRight: Radius.circular(radius),
                            ),
                          ),
                          padding: const EdgeInsetsDirectional.only(
                              start: 20.0, end: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.TxtPopUpReservationType.tr(),
                                style: titleStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                LocaleKeys.TxtPopUpReservationTypeSecond.tr(),
                                style: subTitleSmallStyle.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              verticalSmallSpace,
                              InkWell(
                                onTap: () {
                                  if (kDebugMode) {
                                    print('lab');
                                  }
                                  Navigator.push(
                                    context,
                                    FadeRoute(
                                      page: const LabReservationScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radius),
                                    border:
                                        Border.all(width: 1, color: blueColor),
                                    color: greyExtraLightColor,
                                  ),
                                  child: Row(
                                    children: [
                                      horizontalSmallSpace,
                                      Text(
                                        LocaleKeys.BtnAtLab.tr(),
                                        style: titleStyle.copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: blueColor,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const Spacer(),
                                      Image.asset('assets/images/atLabIcon.png',
                                          height: 40,
                                          width: 30,
                                          color: blueColor),
                                      horizontalSmallSpace,
                                    ],
                                  ),
                                ),
                              ),
                              verticalSmallSpace,
                              InkWell(
                                onTap: () {
                                  if (kDebugMode) {
                                    print('home');
                                  }
                                  Navigator.push(
                                    context,
                                    FadeRoute(
                                      page: const HomeReservationScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radius),
                                    color: greyExtraLightColor,
                                    border:
                                        Border.all(width: 1, color: blueColor),
                                  ),
                                  child: Row(
                                    children: [
                                      horizontalSmallSpace,
                                      Text(
                                        LocaleKeys.BtnAtHome.tr(),
                                        style: titleStyle.copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: blueColor,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.home_outlined,
                                        color: blueColor,
                                        size: 40,
                                      ),
                                      horizontalSmallSpace,
                                    ],
                                  ),
                                ),
                              ),
                              verticalSmallSpace,
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: greyLightColor,
                                    borderRadius: BorderRadius.circular(radius),
                                  ),
                                  child: Center(
                                      child: Text(
                                    LocaleKeys.BtnCancel.tr(),
                                    style: titleStyle.copyWith(
                                        fontSize: 25.0,
                                        color: whiteColor,
                                        fontWeight: FontWeight.normal),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        bottomSheetHeight: 0.5,
                      );
                    } else {
                      showPopUp(
                        context,
                        const VisitorHoldingPopUp(),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: Center(
                      child: Text(
                        LocaleKeys.TxtReservationScreenTitle.tr(),
                        style: titleStyle.copyWith(
                            fontSize: 20.0,
                            color: whiteColor,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    showCustomBottomSheet(
                      context,
                      bottomSheetContent: Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius),
                            topRight: Radius.circular(radius),
                          ),
                        ),
                        padding: const EdgeInsetsDirectional.only(
                            start: 20.0, end: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            verticalMicroSpace,
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/checkTrue.svg',
                                ),
                                horizontalMiniSpace,
                                Text(
                                  LocaleKeys.txtReservationSucceeded.tr(),
                                  style: titleStyle.copyWith(fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            Text(
                              LocaleKeys.TxtPopUpReservationTypeSecond.tr(),
                              style: subTitleSmallStyle.copyWith(
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              height: 110.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(radius),
                                border: Border.all(
                                  width: 1,
                                  color: greyDarkColor,
                                ),
                              ),
                              alignment: AlignmentDirectional.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 10.0, top: 10.0),
                                    child: Image.asset(
                                      'assets/images/logo.png',
                                      width: 80,
                                      height: 80,
                                    ),
                                  ),
                                  horizontalMiniSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        verticalMiniSpace,
                                        Text(
                                          'Fasting sugar FBS',
                                          style: titleStyle.copyWith(
                                              fontWeight: FontWeight.normal),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Text(
                                            'Sugar Checks',
                                            style: TextStyle(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '80 ${LocaleKeys.salary.tr()}',
                                              style: titleStyle.copyWith(
                                                  fontSize: 15),
                                            ),
                                            horizontalMiniSpace,
                                            Text(
                                              '100 ${LocaleKeys.salary.tr()}',
                                              style:
                                                  subTitleSmallStyle.copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            verticalMicroSpace,
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radius),
                                color: greyExtraLightColor,
                              ),
                              child: Row(
                                children: [
                                  horizontalSmallSpace,
                                  Text(
                                    LocaleKeys.txtTotal.tr(),
                                    style: titleStyle.copyWith(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '80 ${LocaleKeys.salary.tr()}',
                                    style: titleStyle.copyWith(fontSize: 18),
                                  ),
                                  horizontalSmallSpace,
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 80.0,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: MaterialButton(
                                        onPressed: () {
                                          if (AppCubit.get(context).isVisitor ==
                                              false) {
                                            Navigator.push(
                                              context,
                                              FadeRoute(
                                                page: const CardScreen(),
                                              ),
                                            );
                                          } else {
                                            showPopUp(
                                              context,
                                              const VisitorHoldingPopUp(),
                                            );
                                          }
                                        },
                                        height: 80.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: blueColor,
                                            borderRadius:
                                                BorderRadius.circular(radius),
                                          ),
                                          height: 50.0,
                                          width: double.infinity,
                                          child: Center(
                                            child: Text(
                                              LocaleKeys.BtnCheckout.tr(),
                                              style: titleSmallStyle.copyWith(
                                                color: whiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GeneralUnfilledButton(
                                        width: double.infinity,
                                        title: LocaleKeys.BtnBrowse.tr(),
                                        onPress: () {
                                          AppCubit.get(context)
                                              .changeBottomScreen(0);
                                          navigateAndFinish(
                                            context,
                                            const HomeLayoutScreen(),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      bottomSheetHeight: 0.55,
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      border: Border.all(color: greyLightColor, width: 1),
                      color: whiteColor,
                    ),
                    child: const Icon(
                      Icons.add_circle,
                      size: 30,
                      color: greyLightColor,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
