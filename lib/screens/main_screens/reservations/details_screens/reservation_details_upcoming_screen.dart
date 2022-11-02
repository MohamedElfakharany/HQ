// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/models/home_appointments_model/home_reservation_model.dart';
import 'package:hq/models/lab_appointments_model/lab_reservation_model.dart';
import 'package:hq/screens/main_screens/home_layout_screen.dart';
import 'package:hq/shared/components/cached_network_image.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ReservationDetailsUpcomingScreen extends StatefulWidget {
  ReservationDetailsUpcomingScreen(
      {Key? key,
      this.labReservationsModel,
      this.homeReservationsModel,
      required this.index})
      : super(key: key);
  LabReservationsModel? labReservationsModel;
  HomeReservationsModel? homeReservationsModel;
  final int index;

  @override
  State<ReservationDetailsUpcomingScreen> createState() =>
      _ReservationDetailsUpcomingScreenState();
}

class _ReservationDetailsUpcomingScreenState
    extends State<ReservationDetailsUpcomingScreen> {
  @override
  void initState() {
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
        AppCubit.get(context).getLabReservations();
        AppCubit.get(context).getHomeReservations();
        // showCustomBottomSheet(context,
        //         bottomSheetContent: const ExperienceRateScreen(),
        //         bottomSheetHeight: 0.65);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String title;
    String image;
    int price;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var labReservationsDataModel = widget.labReservationsModel?.data?[widget.index];
        var homeReservationsDataModel = widget.homeReservationsModel?.data?[widget.index];
        if (labReservationsDataModel?.tests?.isEmpty ??
            widget.homeReservationsModel!.data![widget.index].tests!.isEmpty) {
          title = labReservationsDataModel?.offers?[widget.index].title ??
              widget.homeReservationsModel!.data?[widget.index].offers?.first
                  .title;
          price = labReservationsDataModel?.offers?[widget.index].price ??
              widget.homeReservationsModel!.data?[widget.index].offers?.first
                  .price;
          image = labReservationsDataModel?.offers?[widget.index].image ?? imageTest;
        } else if (labReservationsDataModel?.offers?.isEmpty ??
            widget.homeReservationsModel!.data![widget.index].offers!.isEmpty) {
          title = labReservationsDataModel?.tests?.first.title ??
              widget.homeReservationsModel!.data?[widget.index].tests?.first
                  .title;
          price = labReservationsDataModel?.offers?[widget.index].price ??
              widget.homeReservationsModel!.data?[widget.index].offers?.first
                  .price;
          image = labReservationsDataModel?.tests?.first.image ?? imageTest;
        } else {
          title = '';
          image = '';
          price = 0;
        }
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
          body: ConditionalBuilder(
            condition: state is! AppGetLabReservationsLoadingState || state is! AppGetHomeReservationsLoadingState,
            builder: (context) => Padding(
              padding:
              const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                physics: const BouncingScrollPhysics(),
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
                    padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '# ${widget.homeReservationsModel?.data?[widget.index].id ?? labReservationsDataModel?.id}',
                          ),
                          const Spacer(),
                          Container(
                            height: 36,
                            decoration: BoxDecoration(
                              color: mainLightColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(radius),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: Text(
                                widget.homeReservationsModel?.data?[widget.index]
                                    .status ??
                                    labReservationsDataModel?.status,
                                style: titleStyle.copyWith(
                                    fontSize: 15.0,
                                    color: mainColor,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalMediumSpace,
                  // Text(
                  //   '${LocaleKeys.homeTxtTestLibrary.tr()} (03)',
                  //   style: titleStyle.copyWith(fontWeight: FontWeight.w500),
                  // ),
                  verticalSmallSpace,
                  if (widget.homeReservationsModel != null)
                    SizedBox(
                      height: 120.0 *
                          ((widget.homeReservationsModel?.data?[widget.index]
                              .offers?.length)! +
                              (widget.homeReservationsModel?.data?[widget.index]
                                  .tests?.length ??
                                  0)),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 4),
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Row(
                                children: [
                                  horizontalMicroSpace,
                                  CachedNetworkImageNormal(
                                    imageUrl: image,
                                    width: 80,
                                    height: 80,
                                  ),
                                  horizontalSmallSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          title,
                                          style: titleSmallStyle,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '$price ${LocaleKeys.salary.tr()}',
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
                        itemCount: (widget.homeReservationsModel
                            ?.data?[widget.index].offers?.length ??
                            0) +
                            (widget.homeReservationsModel?.data?[widget.index]
                                .tests?.length ??
                                0),
                      ),
                    ),
                  if (labReservationsDataModel != null)
                    SizedBox(
                      height: 120.0 *
                          ((labReservationsDataModel.offers?.length ?? 0) +
                              (labReservationsDataModel.tests?.length ?? 0)),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 4),
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Row(
                                children: [
                                  horizontalMicroSpace,
                                  CachedNetworkImageNormal(
                                    imageUrl: image,
                                    width: 80,
                                    height: 80,
                                  ),
                                  horizontalSmallSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          title,
                                          style: titleSmallStyle,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '$price ${LocaleKeys.salary.tr()}',
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
                        itemCount: ((labReservationsDataModel.offers?.length ?? 0) + (labReservationsDataModel.tests?.length ?? 0)),
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
                    padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
                                color: mainColor,
                              ),
                              myVerticalDivider(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    LocaleKeys.txtPatient.tr(),
                                    style: titleStyle.copyWith(
                                        color: greyLightColor),
                                  ),
                                  Text(
                                    textAlign: TextAlign.start,
                                    '${AppCubit.get(context).userResourceModel?.data?.name}',
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
                                'assets/images/location.jpg',
                                width: 25,
                                height: 35,
                              ),
                              myVerticalDivider(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    LocaleKeys.txtReservationDetails.tr(),
                                    style: titleStyle.copyWith(
                                        color: greyLightColor),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      '${widget.homeReservationsModel?.data?[widget.index].address?.address ?? labReservationsDataModel?.branch?.title}  ${widget.homeReservationsModel?.data?[widget.index].address?.specialMark ?? ''}',
                                      style: subTitleSmallStyle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                                'assets/images/reserved.png',
                                width: 25,
                                height: 35,
                                color: mainColor,
                              ),
                              myVerticalDivider(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    LocaleKeys.AppointmentScreenTxtTitle.tr(),
                                    style: titleStyle.copyWith(
                                        color: greyLightColor),
                                  ),
                                  Text(
                                    textAlign: TextAlign.start,
                                    '${labReservationsDataModel?.date ?? widget.homeReservationsModel?.data?[widget.index].date} - ${labReservationsDataModel?.time ?? widget.homeReservationsModel?.data?[widget.index].time}',
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
                    padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     Text(
                              //       LocaleKeys.txtItems.tr(),
                              //       style: titleSmallStyle.copyWith(
                              //           color: greyDarkColor,
                              //           fontWeight: FontWeight.normal),
                              //     ),
                              //     const Spacer(),
                              //     const Text(
                              //       textAlign: TextAlign.start,
                              //       '03',
                              //       style: titleSmallStyle,
                              //       maxLines: 1,
                              //       overflow: TextOverflow.ellipsis,
                              //     ),
                              //   ],
                              // ),
                              // verticalMicroSpace,
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
                                    '${labReservationsDataModel?.price ?? widget.homeReservationsModel?.data?[widget.index].price} ${LocaleKeys.salary.tr()}',
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
                                  Text(
                                    textAlign: TextAlign.start,
                                    '${labReservationsDataModel?.tax ?? homeReservationsDataModel?.tax} %',
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
                                    '${labReservationsDataModel?.total ?? homeReservationsDataModel?.total} ${LocaleKeys.salary.tr()}',
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
                                      LocaleKeys.txtPopUpMainCancelReservation
                                          .tr(),
                                      textAlign: TextAlign.center,
                                      style: titleStyle.copyWith(
                                        color: redColor,
                                      ),
                                    ),
                                    verticalMediumSpace,
                                    Text(
                                      LocaleKeys
                                          .txtPopUpSecondaryCancelReservation
                                          .tr(),
                                      textAlign: TextAlign.center,
                                      style: subTitleSmallStyle,
                                    ),
                                    verticalMediumSpace,
                                    GeneralButton(
                                      radius: radius,
                                      btnBackgroundColor: redColor,
                                      title:
                                      LocaleKeys.txtUnderstandContinue.tr(),
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
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
