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
  Color bgColorTest = whiteColor;
  Color bgColorOffer = mainColor;
  Color fontColorTest = mainColor;
  Color fontColorOffer = whiteColor;

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        bgColorTest = index == 0 ? mainLightColor : whiteColor;
        bgColorOffer = index == 1 ? mainLightColor : whiteColor;
        fontColorTest = index == 1 ? mainLightColor : whiteColor;
        fontColorOffer = index == 0 ? mainLightColor : whiteColor;
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: greyExtraLightColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                        bottom: TabBar(
                          indicator: const BoxDecoration(),
                          onTap: (i){
                            setState((){
                              index = i;
                            });
                          },
                          tabs: [
                            Tab(
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: mainLightColor, width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                      Colors.grey.withOpacity(0.15),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  color: bgColorTest,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/atLabIcon.png',
                                      width: 25,
                                      height: 25,
                                      color: fontColorTest,
                                    ),
                                    horizontalMiniSpace,
                                    Text(
                                      LocaleKeys.BtnAtLab.tr(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: fontColorTest,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: mainLightColor, width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                      Colors.grey.withOpacity(0.15),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  color: bgColorOffer,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/atHomeIcon.png',
                                      width: 25,
                                      height: 25,
                                      color: fontColorOffer,
                                    ),
                                    horizontalMiniSpace,
                                    Text(
                                      LocaleKeys.BtnAtHome.tr(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: fontColorOffer,
                                      ),
                                    ),
                                  ],
                                ),
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
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          // first tab bar view widget
                          ConditionalBuilder(
                            condition: AppCubit.get(context).labReservationsModel?.data?.isEmpty == false,
                            builder: (context) => Column(
                              children: [
                                verticalSmallSpace,
                                ConditionalBuilder(
                                  condition: state
                                      is! AppGetLabReservationsLoadingState,
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
                                                topIndex: index,
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
                                      itemCount: AppCubit.get(context)
                                              .labReservationsModel
                                              ?.data
                                              ?.length ??
                                          0,
                                    ),
                                  ),
                                  fallback: (context) => const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                ),
                              ],
                            ),
                            fallback: (context) => ScreenHolder(
                                msg:
                                    '${LocaleKeys.txtReservations.tr()} ${LocaleKeys.BtnAtLab.tr()}'),
                          ),
                          // second tab bar view widget
                          ConditionalBuilder(
                            condition: AppCubit.get(context).homeReservationsModel?.data?.isEmpty == false,
                            builder: (context) => Column(
                              children: [
                                verticalSmallSpace,
                                ConditionalBuilder(
                                  condition: state
                                          is! AppGetHomeReservationsLoadingState,
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
                                                topIndex: index,
                                                homeReservationsModel:
                                                    AppCubit.get(context)
                                                        .homeReservationsModel,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: ReservedCard(
                                            homeReservationsDataModel:
                                                AppCubit.get(context)
                                                    .homeReservationsModel!
                                                    .data![index],
                                          ),
                                        ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          verticalMiniSpace,
                                      itemCount: AppCubit.get(context)
                                              .homeReservationsModel
                                              ?.data
                                              ?.length ??
                                          0,
                                    ),
                                  ),
                                  fallback: (context) => const Center(child: CircularProgressIndicator.adaptive()),
                                ),
                              ],
                            ),
                            fallback: (context) => ScreenHolder(msg: '${LocaleKeys.txtReservations.tr()} ${LocaleKeys.BtnAtHome.tr()}'),
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
