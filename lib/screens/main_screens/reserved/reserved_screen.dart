import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/main_screens/profile/region_settings/change_language.dart';
import 'package:hq/screens/main_screens/reservations/details_screens/upcoming_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ReservedScreen extends StatelessWidget {
  const ReservedScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: greyExtraLightColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  // the tab bar with two items
                  if (AppCubit.get(context).isVisitor == true)
                    const Expanded(
                      child: VisitorHolderScreen(),
                    ),
                  if (AppCubit.get(context).isVisitor == false)
                    SizedBox(
                      height: 60,
                      child: AppBar(
                        backgroundColor: greyExtraLightColor,
                        elevation: 0.0,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(20),
                        // ),
                        bottom: TabBar(
                          tabs: [
                            Tab(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: blueLightColor, width: 2),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.15),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                        color: whiteColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          LocaleKeys.txtAll.tr(),
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: darkColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  verticalMicroSpace,
                                ],
                              ),
                            ),
                            Tab(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: blueLightColor, width: 2),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.15),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                        color: whiteColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          LocaleKeys.txtUpcoming.tr(),
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: darkColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  verticalMicroSpace,
                                ],
                              ),
                            ),
                            Tab(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 60,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: blueLightColor, width: 2),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.15),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                        color: whiteColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          LocaleKeys.txtCanceled.tr(),
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: darkColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  verticalMicroSpace,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  // create widgets for each tab bar here
                  if (AppCubit.get(context).isVisitor == false)
                    Expanded(
                      child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          // first tab bar view widget
                          Column(
                            children: [
                              verticalSmallSpace,
                              Expanded(
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        FadeRoute(
                                          page:
                                              const ReservationDetailsUpcomingScreen(),
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      height: 150,
                                      child: Container(
                                        height: 110.0,
                                        width: 110.0,
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(radius),
                                          border: Border.all(
                                            width: 1,
                                            color: greyLightColor,
                                          ),
                                        ),
                                        alignment: AlignmentDirectional.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 4),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '#150-450-600',
                                                    style: titleSmallStyle
                                                        .copyWith(
                                                            fontSize: 15.0),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '80 SAR',
                                                    style: titleStyle.copyWith(
                                                        fontSize: 18.0),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                              const Text(
                                                'Glaciated Hemoglobin HBA1C',
                                                style: titleSmallStyle,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const Text(
                                                '24 Feb 2022 - 5:30 PM',
                                                style: titleSmallStyle2,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Container(
                                                height: 36,
                                                width: 130,
                                                decoration: BoxDecoration(
                                                  color: greenColor
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          radius),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Center(
                                                    child: Text(
                                                  LocaleKeys.txtAll.tr(),
                                                  style: titleStyle.copyWith(
                                                      fontSize: 15.0,
                                                      color: greenColor,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      verticalMiniSpace,
                                  itemCount: 10,
                                ),
                              ),
                            ],
                          ),
                          // second tab bar view widget
                          Column(
                            children: [
                              verticalSmallSpace,
                              Expanded(
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        FadeRoute(
                                          page:
                                              const ReservationDetailsUpcomingScreen(),
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      height: 150,
                                      child: Container(
                                        height: 110.0,
                                        width: 110.0,
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(radius),
                                          border: Border.all(
                                            width: 1,
                                            color: greyLightColor,
                                          ),
                                        ),
                                        alignment: AlignmentDirectional.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 4),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '#150-450-600',
                                                    style: titleSmallStyle
                                                        .copyWith(
                                                            fontSize: 15.0),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '80 SAR',
                                                    style: titleStyle.copyWith(
                                                        fontSize: 18.0),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                              const Text(
                                                'Glaciated Hemoglobin HBA1C',
                                                style: titleSmallStyle,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const Text(
                                                '24 Feb 2022 - 5:30 PM',
                                                style: titleSmallStyle2,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Container(
                                                height: 36,
                                                width: 130,
                                                decoration: BoxDecoration(
                                                  color: blueLightColor
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          radius),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Center(
                                                    child: Text(
                                                  LocaleKeys.txtUpcoming.tr(),
                                                  style: titleStyle.copyWith(
                                                      fontSize: 15.0,
                                                      color: blueColor,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      verticalMiniSpace,
                                  itemCount: 10,
                                ),
                              ),
                            ],
                          ),
                          // third tab bar view widget
                          Column(
                            children: [
                              verticalSmallSpace,
                              Expanded(
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        FadeRoute(
                                          page:
                                              const ReservationDetailsUpcomingScreen(),
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      height: 150,
                                      child: Container(
                                        height: 110.0,
                                        width: 110.0,
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(radius),
                                          border: Border.all(
                                            width: 1,
                                            color: greyLightColor,
                                          ),
                                        ),
                                        alignment: AlignmentDirectional.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 4),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '#150-450-600',
                                                    style: titleSmallStyle
                                                        .copyWith(
                                                            fontSize: 15.0),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '80 SAR',
                                                    style: titleStyle.copyWith(
                                                        fontSize: 18.0),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                              const Text(
                                                'Glaciated Hemoglobin HBA1C',
                                                style: titleSmallStyle,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const Text(
                                                '24 Feb 2022 - 5:30 PM',
                                                style: titleSmallStyle2,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Container(
                                                height: 36,
                                                width: 130,
                                                decoration: BoxDecoration(
                                                  color:
                                                      redColor.withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          radius),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Center(
                                                    child: Text(
                                                  'Canceled',
                                                  style: titleStyle.copyWith(
                                                      fontSize: 15.0,
                                                      color: redColor,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      verticalMiniSpace,
                                  itemCount: 10,
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
          ),
        );
      },
    );
  }
}
