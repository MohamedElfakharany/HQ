import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/main_screens/profile/region_settings/change_language.dart';
import 'package:hq/screens/main_screens/reservations/details_screens/reservation_details_upcoming_screen.dart';
import 'package:hq/screens/main_screens/reserved/widget_components.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ReservedScreen extends StatefulWidget {
  const ReservedScreen({Key? key}) : super(key: key);

  @override
  State<ReservedScreen> createState() => _ReservedScreenState();
}

class _ReservedScreenState extends State<ReservedScreen> {
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getLabReservations();
    AppCubit.get(context).getHomeReservations();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/atLabIcon.png',
                                            width: 25,
                                            height: 25,
                                            color: blueColor,
                                          ),
                                          horizontalSmallSpace,
                                          Text(
                                            LocaleKeys.BtnAtLab.tr(),
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: darkColor,
                                            ),
                                          ),
                                        ],
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/atHomeIcon.png',
                                            width: 25,
                                            height: 25,
                                            color: blueColor,
                                          ),
                                          horizontalSmallSpace,
                                          Text(
                                            LocaleKeys.BtnAtHome.tr(),
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: darkColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  verticalMicroSpace,
                                ],
                              ),
                            ),
                            // Tab(
                            //   child: Column(
                            //     children: [
                            //       Expanded(
                            //         child: Container(
                            //           height: 60,
                            //           width: double.infinity,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(8),
                            //             border: Border.all(
                            //                 color: blueLightColor, width: 2),
                            //             boxShadow: [
                            //               BoxShadow(
                            //                 color:
                            //                     Colors.grey.withOpacity(0.15),
                            //                 spreadRadius: 2,
                            //                 blurRadius: 2,
                            //                 offset: const Offset(0, 2),
                            //               ),
                            //             ],
                            //             color: whiteColor,
                            //           ),
                            //           child: Center(
                            //             child: Text(
                            //               LocaleKeys.txtCanceled.tr(),
                            //               textAlign: TextAlign.start,
                            //               style: const TextStyle(
                            //                 fontSize: 14,
                            //                 color: darkColor,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //       verticalMicroSpace,
                            //     ],
                            //   ),
                            // ),
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
                              ConditionalBuilder(
                                condition:
                                    state is! AppGetLabReservationsLoadingState,
                                builder: (context) => Expanded(
                                  child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          FadeRoute(
                                            page:
                                                ReservationDetailsUpcomingScreen(
                                                  index: index,
                                              labReservationsModel:
                                                  AppCubit.get(context)
                                                      .labReservationsModel,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ReservedCard(
                                        labReservationsDataModel:
                                            AppCubit.get(context)
                                                .labReservationsModel!
                                                .data![index],
                                      ),
                                    ),
                                    separatorBuilder: (context, index) =>
                                        verticalMiniSpace,
                                    itemCount: AppCubit.get(context).labReservationsModel?.data?.length ?? 0,
                                  ),
                                ),
                                fallback: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ],
                          ),
                          // second tab bar view widget
                          Column(
                            children: [
                              verticalSmallSpace,
                              ConditionalBuilder(
                                condition: state
                                    is! AppGetHomeReservationsLoadingState || state is! AppGetLabReservationsLoadingState,
                                builder: (context) => Expanded(
                                  child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          FadeRoute(
                                            page:
                                            ReservationDetailsUpcomingScreen(
                                              index: index,
                                              homeReservationsModel:
                                              AppCubit.get(context)
                                                  .homeReservationsModel,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ReservedCard(
                                        homeReservationsDataModel:
                                            AppCubit.get(context)
                                                .homeReservationsModel!
                                                .data![index],
                                      ),
                                    ),
                                    separatorBuilder: (context, index) =>
                                        verticalMiniSpace,
                                    itemCount: AppCubit.get(context).homeReservationsModel?.data?.length ?? 0,
                                  ),
                                ),
                                fallback: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ],
                          ),
                          // third tab bar view widget
                          // Column(
                          //   children: [
                          //     verticalSmallSpace,
                          //     Expanded(
                          //       child: ListView.separated(
                          //         physics: const BouncingScrollPhysics(),
                          //         scrollDirection: Axis.vertical,
                          //         itemBuilder: (context, index) => InkWell(
                          //           onTap: () {
                          //             Navigator.push(
                          //               context,
                          //               FadeRoute(
                          //                 page:
                          //                     const ReservationDetailsUpcomingScreen(),
                          //               ),
                          //             );
                          //           },
                          //           child: SizedBox(
                          //             height: 150,
                          //             child: Container(
                          //               height: 110.0,
                          //               width: 110.0,
                          //               decoration: BoxDecoration(
                          //                 color: whiteColor,
                          //                 borderRadius:
                          //                     BorderRadius.circular(radius),
                          //                 border: Border.all(
                          //                   width: 1,
                          //                   color: greyLightColor,
                          //                 ),
                          //               ),
                          //               alignment: AlignmentDirectional.center,
                          //               padding: const EdgeInsets.symmetric(
                          //                   vertical: 0, horizontal: 4),
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(10.0),
                          //                 child: Column(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceEvenly,
                          //                   children: [
                          //                     Row(
                          //                       children: [
                          //                         Text(
                          //                           '#150-450-600',
                          //                           style: titleSmallStyle
                          //                               .copyWith(
                          //                                   fontSize: 15.0),
                          //                           maxLines: 1,
                          //                           overflow:
                          //                               TextOverflow.ellipsis,
                          //                         ),
                          //                         const Spacer(),
                          //                         Text(
                          //                           '80 SAR',
                          //                           style: titleStyle.copyWith(
                          //                               fontSize: 18.0),
                          //                           maxLines: 1,
                          //                           overflow:
                          //                               TextOverflow.ellipsis,
                          //                         ),
                          //                       ],
                          //                     ),
                          //                     const Text(
                          //                       'Glaciated Hemoglobin HBA1C',
                          //                       style: titleSmallStyle,
                          //                       maxLines: 1,
                          //                       overflow: TextOverflow.ellipsis,
                          //                     ),
                          //                     const Text(
                          //                       '24 Feb 2022 - 5:30 PM',
                          //                       style: titleSmallStyle2,
                          //                       maxLines: 1,
                          //                       overflow: TextOverflow.ellipsis,
                          //                     ),
                          //                     Container(
                          //                       height: 36,
                          //                       width: 130,
                          //                       decoration: BoxDecoration(
                          //                         color:
                          //                             redColor.withOpacity(0.2),
                          //                         borderRadius:
                          //                             BorderRadius.circular(
                          //                                 radius),
                          //                       ),
                          //                       padding:
                          //                           const EdgeInsets.symmetric(
                          //                               horizontal: 8.0),
                          //                       child: Center(
                          //                           child: Text(
                          //                         'Canceled',
                          //                         style: titleStyle.copyWith(
                          //                             fontSize: 15.0,
                          //                             color: redColor,
                          //                             fontWeight:
                          //                                 FontWeight.normal),
                          //                       )),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         separatorBuilder: (context, index) =>
                          //             verticalMiniSpace,
                          //         itemCount: 10,
                          //       ),
                          //     ),
                          //   ],
                          // ),
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
