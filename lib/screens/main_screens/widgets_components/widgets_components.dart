// ignore_for_file: library_private_types_in_public_api

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/models/model_test.dart';
import 'package:hq/screens/intro_screens/startup/onboarding_screen.dart';
import 'package:hq/screens/main_screens/card_screen.dart';
import 'package:hq/screens/main_screens/home_layout_screen.dart';
import 'package:hq/screens/main_screens/test_items_screen/test_details_screen.dart';
import 'package:hq/shared/components/cached_network_image.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';
import 'package:table_calendar/table_calendar.dart';

class LabCalenderView extends StatefulWidget {
  const LabCalenderView({super.key});

  @override
  _LabCalenderViewState createState() => _LabCalenderViewState();
}

class _LabCalenderViewState extends State<LabCalenderView> {
  // final DateTime _currentDay = DateTime.now();
  final DateTime _today = DateTime.now();
  DateTime? _selectedDay;

  dynamic day;
  dynamic month;

  final CalendarFormat _calendarFormat = CalendarFormat.month;

  // List<SessionModel> _getEventsForDay(DateTime day) {
  //   return [];
  // }
  // final bool _loadingData = true;
  // final bool _isCurrentMonthChanged = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: whiteColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 10.0),
                    child: TableCalendar(
                      locale: sharedLanguage,
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _today,
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.saturday,
                      daysOfWeekHeight: 30,
                      rowHeight: 40,
                      // eventLoader: _getEventsForDay,
                      // for badge under day
                      selectedDayPredicate: (day) {
                        // Use `selectedDayPredicate` to determine which day is currently selected.
                        // If this returns true, then `day` will be marked as selected.

                        // Using `isSameDay` is recommended to disregard
                        // the time-part of compared DateTime objects.
                        return isSameDay(_selectedDay, day);
                      },
                      onFormatChanged: (format) {
                        // if (_calendarFormat == CalendarFormat.month) {
                        //   setState(() {
                        //     _calendarFormat = CalendarFormat.twoWeeks;
                        //   });
                        // }
                        // else if ( _calendarFormat == CalendarFormat.twoWeeks){
                        //   setState(() {
                        //     _calendarFormat = CalendarFormat.week;
                        //   });
                        // }
                        // else if (_calendarFormat == CalendarFormat.week){
                        //   setState(() {
                        //     _calendarFormat = CalendarFormat.month;
                        //   });
                        // }
                      },

                      onCalendarCreated: (controller) {
                        // Provider.of<ShiftsProvider>(context,listen: false).fetchCalendarDaysWithOffers(context,startDate: widget.startDate,endDate: widget.endDate,historyType: widget.historyType);
                      },

                      onPageChanged: (DateTime day) {
                        // to save current page in Calendar when page changed .
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          // Call `setState()` when updating the selected day
                          setState(() {
                            _selectedDay = selectedDay;
                          });
                        }
                        if (selectedDay.day <= 9) {
                          day = '0${selectedDay.day}';
                        } else {
                          day = selectedDay.day;
                        }

                        if (selectedDay.month <= 9) {
                          month = '0${selectedDay.month}';
                        } else {
                          month = selectedDay.month;
                        }

                        // AppCubit.get(context).getLabAppointmentsData(
                        //     date:
                        //     '${selectedDay.year.toString()}-${month.toString()}-${day.toString()}');
                      },
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month',
                      },
                      headerStyle: HeaderStyle(
                        headerPadding: EdgeInsets.symmetric(horizontal: 0.2.sw),
                        // rightChevronIcon: Transform.rotate(
                        //     angle: Provider.of<LocalizationController>(context,
                        //                     listen: false)
                        //                 .locale
                        //                 .languageCode ==
                        //             "ar"
                        //         ? rightRotationAngle
                        //         : leftRotationAngle,
                        //     child: SvgPicture.asset("assets/dropDownArrow.svg",
                        //         color: greenBlue, height: 0.03.sw)),
                        // leftChevronIcon: Transform.rotate(
                        //     angle: Provider.of<LocalizationController>(context,
                        //                     listen: false)
                        //                 .locale
                        //                 .languageCode ==
                        //             "ar"
                        //         ? leftRotationAngle
                        //         : rightRotationAngle,
                        //     child: SvgPicture.asset("assets/dropDownArrow.svg",
                        //         color: greenBlue, height: 0.03.sw)),
                      ),
                      calendarStyle: const CalendarStyle(
                        selectedTextStyle:
                        TextStyle(color: whiteColor, fontSize: 20),
                        todayDecoration: BoxDecoration(),
                        todayTextStyle: TextStyle(
                            color: greenColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                        selectedDecoration: BoxDecoration(
                            color: greenColor, shape: BoxShape.circle),
                        defaultDecoration: BoxDecoration(),
                        holidayDecoration:
                        BoxDecoration(shape: BoxShape.circle),
                        weekendDecoration:
                        BoxDecoration(shape: BoxShape.circle),
                        rangeEndDecoration:
                        BoxDecoration(shape: BoxShape.circle),
                        outsideDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        disabledDecoration:
                        BoxDecoration(shape: BoxShape.circle),
                        // weekendTextStyle: const TextStyle(
                        //   color: blueColor,
                        // ),
                        markerSize: 40.0,
                        markerDecoration: BoxDecoration(),
                        isTodayHighlighted: true,
                      ),
                      // formatAnimationCurve: Curves.easeIn,
                      availableGestures: AvailableGestures.horizontalSwipe,
                      // calendarBuilders: CalendarBuilders<SessionModel>(
                      //   dowBuilder: (context, day) {
                      //     return Center(
                      //       child: ExcludeSemantics(
                      //         child: Text(
                      //           "${DateFormat.E("en").format(day)}",
                      //           style: TextStyle(
                      //               color: !_isCurrentMonthChanged &&
                      //                       DateFormat.E("en_US").format(_today) ==
                      //                           DateFormat.E("en_US").format(day)
                      //                   ? Theme.of(context).primaryColor
                      //                   : dustyTeal,
                      //               fontWeight: FontWeight.w400),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        );
      },
    );
  }
}

class HomeCalenderView extends StatefulWidget {
  const HomeCalenderView({super.key});

  @override
  _HomeCalenderViewState createState() => _HomeCalenderViewState();
}

class _HomeCalenderViewState extends State<HomeCalenderView> {
  // final DateTime _currentDay = DateTime.now();
  final DateTime _today = DateTime.now();
  DateTime? _selectedDay;

  dynamic day;
  dynamic month;

  final CalendarFormat _calendarFormat = CalendarFormat.month;

  // List<SessionModel> _getEventsForDay(DateTime day) {
  //   return [];
  // }
  // final bool _loadingData = true;
  // final bool _isCurrentMonthChanged = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: whiteColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 10.0),
                    child: TableCalendar(
                      locale: sharedLanguage,
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _today,
                      calendarFormat: _calendarFormat,
                      startingDayOfWeek: StartingDayOfWeek.saturday,
                      daysOfWeekHeight: 30,
                      rowHeight: 40,
                      // eventLoader: _getEventsForDay,
                      // for badge under day
                      selectedDayPredicate: (day) {
                        // Use `selectedDayPredicate` to determine which day is currently selected.
                        // If this returns true, then `day` will be marked as selected.

                        // Using `isSameDay` is recommended to disregard
                        // the time-part of compared DateTime objects.
                        return isSameDay(_selectedDay, day);
                      },
                      onFormatChanged: (format) {
                        // if (_calendarFormat == CalendarFormat.month) {
                        //   setState(() {
                        //     _calendarFormat = CalendarFormat.twoWeeks;
                        //   });
                        // }
                        // else if ( _calendarFormat == CalendarFormat.twoWeeks){
                        //   setState(() {
                        //     _calendarFormat = CalendarFormat.week;
                        //   });
                        // }
                        // else if (_calendarFormat == CalendarFormat.week){
                        //   setState(() {
                        //     _calendarFormat = CalendarFormat.month;
                        //   });
                        // }
                      },

                      onCalendarCreated: (controller) {
                        // Provider.of<ShiftsProvider>(context,listen: false).fetchCalendarDaysWithOffers(context,startDate: widget.startDate,endDate: widget.endDate,historyType: widget.historyType);
                      },

                      onPageChanged: (DateTime day) {
                        // to save current page in Calendar when page changed .
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          // Call `setState()` when updating the selected day
                          setState(() {
                            _selectedDay = selectedDay;
                          });
                        }
                        if (selectedDay.day <= 9) {
                          day = '0${selectedDay.day}';
                        } else {
                          day = selectedDay.day;
                        }

                        if (selectedDay.month <= 9) {
                          month = '0${selectedDay.month}';
                        } else {
                          month = selectedDay.month;
                        }

                        // AppCubit.get(context).getLabAppointmentsData(
                        //     date:
                        //     '${selectedDay.year.toString()}-${month.toString()}-${day.toString()}');
                      },
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month',
                      },
                      headerStyle: HeaderStyle(
                        headerPadding: EdgeInsets.symmetric(horizontal: 0.2.sw),
                        // rightChevronIcon: Transform.rotate(
                        //     angle: Provider.of<LocalizationController>(context,
                        //                     listen: false)
                        //                 .locale
                        //                 .languageCode ==
                        //             "ar"
                        //         ? rightRotationAngle
                        //         : leftRotationAngle,
                        //     child: SvgPicture.asset("assets/dropDownArrow.svg",
                        //         color: greenBlue, height: 0.03.sw)),
                        // leftChevronIcon: Transform.rotate(
                        //     angle: Provider.of<LocalizationController>(context,
                        //                     listen: false)
                        //                 .locale
                        //                 .languageCode ==
                        //             "ar"
                        //         ? leftRotationAngle
                        //         : rightRotationAngle,
                        //     child: SvgPicture.asset("assets/dropDownArrow.svg",
                        //         color: greenBlue, height: 0.03.sw)),
                      ),
                      calendarStyle: const CalendarStyle(
                        selectedTextStyle:
                        TextStyle(color: whiteColor, fontSize: 20),
                        todayDecoration: BoxDecoration(),
                        todayTextStyle: TextStyle(
                            color: greenColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                        selectedDecoration: BoxDecoration(
                            color: greenColor, shape: BoxShape.circle),
                        defaultDecoration: BoxDecoration(),
                        holidayDecoration:
                        BoxDecoration(shape: BoxShape.circle),
                        weekendDecoration:
                        BoxDecoration(shape: BoxShape.circle),
                        rangeEndDecoration:
                        BoxDecoration(shape: BoxShape.circle),
                        outsideDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        disabledDecoration:
                        BoxDecoration(shape: BoxShape.circle),
                        // weekendTextStyle: const TextStyle(
                        //   color: blueColor,
                        // ),
                        markerSize: 40.0,
                        markerDecoration: BoxDecoration(),
                        isTodayHighlighted: true,
                      ),
                      // formatAnimationCurve: Curves.easeIn,
                      availableGestures: AvailableGestures.horizontalSwipe,
                      // calendarBuilders: CalendarBuilders<SessionModel>(
                      //   dowBuilder: (context, day) {
                      //     return Center(
                      //       child: ExcludeSemantics(
                      //         child: Text(
                      //           "${DateFormat.E("en").format(day)}",
                      //           style: TextStyle(
                      //               color: !_isCurrentMonthChanged &&
                      //                       DateFormat.E("en_US").format(_today) ==
                      //                           DateFormat.E("en_US").format(day)
                      //                   ? Theme.of(context).primaryColor
                      //                   : dustyTeal,
                      //               fontWeight: FontWeight.w400),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        );
      },
    );
  }
}

class OffersCard extends StatefulWidget {
  const OffersCard({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<OffersCard> createState() => _OffersCardState();
}

class _OffersCardState extends State<OffersCard> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.9,
          height: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 165,
                width: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    CachedNetworkImageNormal(
                      imageUrl: offersModelData[widget.index].image,
                      height: 165,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                              color: redColor,
                              borderRadius: BorderRadius.circular(radius),
                            ),
                            child: Center(
                              child: Text(
                                '${offersModelData[widget.index].percent}% Off',
                                style: const TextStyle(color: whiteColor),
                              ),
                            ),
                          ),
                          const Spacer(),
                          if (offersModelData[widget.index].gender == 'male')
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
                                      offersModelData[widget.index].gender,
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
                            ) else
                            if (offersModelData[widget.index].gender == 'female')
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
                                        offersModelData[widget.index].gender,
                                        style: const TextStyle(
                                            color: whiteColor),
                                      ),
                                      horizontalMicroSpace,
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
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Text(
                  offersModelData[widget.index].body,
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
                      '${offersModelData[widget.index].discount} ${LocaleKeys.salary.tr()}',
                      style: titleSmallStyle2,
                    ),
                    horizontalMiniSpace,
                    Text(
                      '${offersModelData[widget.index].price} ${LocaleKeys.salary.tr()}',
                      style: subTitleSmallStyle2.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TestsCard extends StatefulWidget {
  const TestsCard({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<TestsCard> createState() => _TestsCardState();
}

class _TestsCardState extends State<TestsCard> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: 110.0,
          width: 110.0,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              width: 1,
              color: greyDarkColor,
            ),
          ),
          alignment: AlignmentDirectional.center,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                alignment: Alignment.center,
                testsModelData[widget.index].image,
                width: 65,
                height: 65,
              ),
              verticalSmallSpace,
              Text(
                testsModelData[widget.index].body,
                textAlign: TextAlign.center,
                style: subTitleSmallStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}

class TestItemCard extends StatefulWidget {
  const TestItemCard({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<TestItemCard> createState() => _TestItemCardState();
}

class _TestItemCardState extends State<TestItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      width: 110.0,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          width: 1,
          color: greyDarkColor,
        ),
      ),
      alignment: AlignmentDirectional.center,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
      child: Stack(
        children: [
          Stack(
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
                        Text(
                          offersModelData[widget.index].title,
                          style: titleStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          offersModelData[widget.index].body,
                          style: subTitleSmallStyle2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text(
                              '${offersModelData[widget.index].discount} ${LocaleKeys.salary.tr()}',
                              style: titleSmallStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (widget.index % 2 != 0) horizontalMiniSpace,
                            if (widget.index % 2 != 0)
                              Text(
                                '${offersModelData[widget.index].price} ${LocaleKeys.salary.tr()}',
                                style: subTitleSmallStyle2.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              FadeRoute(
                                page: const TestDetailsScreen(),
                              ),
                            );
                          },
                          color: blueColor,
                          child: Text(
                            LocaleKeys.txtDetails.tr(),
                            style: titleSmallStyle.copyWith(color: whiteColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 30,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        horizontalMicroSpace,
                        if (offersModelData[widget.index].gender == 'male')
                          const Center(
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: blueLightColor,
                              child: Icon(
                                Icons.male,
                                size: 25,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        if (offersModelData[widget.index].gender == 'female')
                          const Center(
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: pinkColor,
                              child: Icon(
                                Icons.female,
                                size: 25,
                                color: whiteColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        if (kDebugMode) {
                          print(
                            'plus entered',
                          );
                        }
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
                            padding: const EdgeInsetsDirectional.only(start: 20.0,end: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                verticalMicroSpace,
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/images/checkTrue.svg',),
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
                                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            verticalMiniSpace,
                                            Text(
                                              'Fasting sugar FBS',
                                              style: titleStyle.copyWith(fontWeight: FontWeight.normal),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(vertical: 5.0),
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
                                                  style: titleStyle.copyWith(fontSize: 15),
                                                ),
                                                horizontalMiniSpace,
                                                Text(
                                                  '100 ${LocaleKeys.salary.tr()}',
                                                  style: subTitleSmallStyle.copyWith(
                                                    decoration: TextDecoration.lineThrough,
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
                                        style: titleStyle.copyWith(fontWeight: FontWeight.normal),
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
                                                Navigator.push(context, FadeRoute(page: const CardScreen(),),);
                                              },
                                              height: 80.0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: blueColor,
                                                  borderRadius: BorderRadius.circular(radius),
                                                ),
                                                height: 50.0,
                                                width: double.infinity,
                                                child: Center(
                                                    child: Text(
                                                      LocaleKeys.BtnCheckout.tr(),
                                                      style:
                                                      titleSmallStyle.copyWith(color: whiteColor),
                                                    )),
                                              )),
                                        ),
                                        Expanded(
                                          child: GeneralUnfilledButton(
                                            width: double.infinity,
                                            title: LocaleKeys.BtnBrowse.tr(),
                                            onPress: () {
                                              AppCubit.get(context).changeBottomScreen(0);
                                              navigateAndFinish(context, const HomeLayoutScreen(),);
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
                      child: const CircleAvatar(
                        radius: 15,
                        backgroundColor: greyLightColor,
                        child: Icon(
                          Icons.add,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          if (widget.index % 2 != 0)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    '%',
                    style: TextStyle(color: whiteColor, fontSize: 16),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class VisitorHoldingPopUp extends StatelessWidget {
  const VisitorHoldingPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          verticalSmallSpace,
          Image.asset(
            'assets/images/logo.png',
            width: 150,
            height: 150,
          ),
          verticalLargeSpace,
          Text(LocaleKeys.txtPleaseSignInFirst.tr(),style: titleStyle,),
          verticalLargeSpace,
          GeneralButton(title: LocaleKeys.BtnSignIn.tr(), onPress: (){
            AppCubit.get(context).currentIndex = 0;
            Navigator.pushAndRemoveUntil(context, FadeRoute(page: OnBoardingScreen(),), (route) => false);
          }),
          verticalLargeSpace,
        ],
      ),
    );
  }
}