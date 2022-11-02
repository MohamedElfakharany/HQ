import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/models/test_models/offers_model.dart';
import 'package:hq/models/test_models/tests_model.dart';
import 'package:hq/screens/main_screens/reservations/reserved_success_screen.dart';
import 'package:hq/shared/components/cached_network_image.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class HomeReservationOverviewScreen extends StatefulWidget {
  HomeReservationOverviewScreen(
      {Key? key,
      this.offersDataModel,
      this.testsDataModel,
      required this.date,
      required this.time,
      this.familyId,
      required this.branchId,
      required this.familyName,
      required this.branchName})
      : super(key: key);
  final String date;
  final String time;
  final String branchName;
  final String? familyName;
  final int? familyId;
  final int branchId;
  TestsDataModel? testsDataModel;
  OffersDataModel? offersDataModel;

  @override
  State<HomeReservationOverviewScreen> createState() =>
      _HomeReservationOverviewScreenState();
}

class _HomeReservationOverviewScreenState
    extends State<HomeReservationOverviewScreen> {
  var couponController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  final _focusNodes =
      Iterable<int>.generate(1).map((_) => FocusNode()).toList();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppCheckCouponSuccessState) {
          if (state.successModel.status) {
            AppCubit.get(context).getInvoices(testId: [
              widget.testsDataModel?.id ?? widget.offersDataModel?.id
            ]);
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(state.successModel.message),
              ),
            );
          }
        } else if (state is AppCheckCouponErrorState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(
                state.error.toString(),
              ),
            ),
          );
        }
        if (state is AppCreateHomeReservationSuccessState) {
          if (state.successModel.status) {
            showToast(
              msg: state.successModel.message,
              state: ToastState.success,
            );
            // Navigator.push(context,FadeRoute(page: ));
            navigateAndFinish(
              context,
              ReservedSuccessScreen(
                date: widget.date,
                time: widget.time,
                isLab: false,
                branchName: widget.branchName,
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(state.successModel.message),
              ),
            );
          }
        } else if (state is AppCreateHomeReservationErrorState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(
                state.error.toString(),
              ),
            ),
          );
        }
        if (state is AppGetInvoicesSuccessState) {
          if (state.successModel.status) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(state.successModel.message),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(state.successModel.message),
              ),
            );
          }
        } else if (state is AppGetInvoicesErrorState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(
                state.error.toString(),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (kDebugMode) {
          print('date ya ro7 omak ${widget.date}');
          print('familyId ya ro7 omak ${widget.familyId}');
          print('time ya ro7 omak ${widget.time}');
          print('branchId ya ro7 omak ${widget.branchId}');
          print('familyName ya ro7 omak ${widget.familyName}');
        }
        return Scaffold(
          backgroundColor: greyExtraLightColor,
          appBar: GeneralAppBar(
            title: LocaleKeys.txtOverview.tr(),
            centerTitle: false,
            appBarColor: greyExtraLightColor,
          ),
          body: Padding(
            padding:
                const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
            child: Form(
              key: formKey,
              child: KeyboardActions(
                tapOutsideBehavior: TapOutsideBehavior.translucentDismiss,
                config: KeyboardActionsConfig(
                  // Define ``defaultDoneWidget`` only once in the config
                  defaultDoneWidget: doneKeyboard(),
                  actions: _focusNodes
                      .map((focusNode) =>
                          KeyboardActionsItem(focusNode: focusNode))
                      .toList(),
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 4),
                      child: Row(
                        children: [
                          horizontalMicroSpace,
                          CachedNetworkImageNormal(
                            imageUrl: widget.offersDataModel?.image ??
                                widget.testsDataModel?.image,
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
                                  widget.offersDataModel?.title ??
                                      widget.testsDataModel?.title,
                                  style: titleSmallStyle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  widget.testsDataModel?.category?.name ?? '',
                                  style: subTitleSmallStyle2,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${widget.offersDataModel?.price ?? widget.testsDataModel?.price} ${LocaleKeys.salary.tr()}',
                                  style: titleSmallStyle2,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
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
                      height: 166.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      alignment: AlignmentDirectional.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 4),
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
                                    if (AppCubit.get(context).isVisitor ==
                                        false)
                                      Text(
                                        widget.familyName ??
                                            AppCubit.get(context)
                                                .userResourceModel
                                                ?.data
                                                ?.name,
                                        textAlign: TextAlign.start,
                                        style: titleSmallStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          myHorizontalDivider(),
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
                                      '${widget.date} - ${widget.time}',
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
                      height: 120.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.txtHaveCoupon.tr(),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DefaultFormField(
                                      controller: couponController,
                                      type: TextInputType.number,
                                      label: LocaleKeys.txtFieldCoupon.tr(),
                                      validatedText:
                                          LocaleKeys.txtFieldCoupon.tr(),
                                      onTap: () {},
                                    ),
                                  ),
                                  horizontalMiniSpace,
                                  InkWell(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        AppCubit.get(context).checkCoupon(
                                            coupon: couponController.text);
                                      }
                                    },
                                    child: Container(
                                      width: 55,
                                      height: 55,
                                      decoration: BoxDecoration(
                                          color: darkColor,
                                          borderRadius:
                                              BorderRadius.circular(radius)),
                                      child: const Icon(
                                        Icons.send_outlined,
                                        color: whiteColor,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalMiniSpace,
                    ConditionalBuilder(
                      condition: state is! AppCheckCouponLoadingState &&
                          state is! AppGetInvoicesLoadingState,
                      builder: (context) => Container(
                        height: 250.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        alignment: AlignmentDirectional.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSmallSpace,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                LocaleKeys.txtSummary.tr(),
                                style: titleSmallStyle.copyWith(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            myHorizontalDivider(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                        '${widget.offersDataModel?.price ?? widget.testsDataModel?.price} ${LocaleKeys.salary.tr()}',
                                        style: titleSmallStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  verticalMicroSpace,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    verticalSmallSpace,
                    ConditionalBuilder(
                      condition: state is! AppCreateHomeReservationLoadingState,
                      builder: (context) => MaterialButton(
                        onPressed: () {
                          if (widget.offersDataModel?.id == null) {
                          AppCubit.get(context).createHomeReservation(
                              date: widget.date,
                              time: widget.time,
                              familyId: widget.familyId,
                              branchId: widget.branchId,
                              coupon: couponController.text,
                              testId: [widget.testsDataModel?.id],
                              addressId: '34');
                          }else if (widget.testsDataModel?.id == null){
                            AppCubit.get(context).createHomeReservation(
                                date: widget.date,
                                time: widget.time,
                                familyId: widget.familyId,
                                branchId: widget.branchId,
                                coupon: couponController.text,
                                offerId: [widget.offersDataModel?.id],
                                addressId: '34');
                          }
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: mainColor,
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
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    // MaterialButton(
                    //   onPressed: () {
                    //     // navigateAndFinish(
                    //     //   context,
                    //     //   ReservedSuccessScreen(),
                    //     // );
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       color: blueColor,
                    //       borderRadius: BorderRadius.circular(radius),
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         LocaleKeys.BtnConfirm.tr(),
                    //         style: titleStyle.copyWith(
                    //           fontSize: 20.0,
                    //           color: whiteColor,
                    //           fontWeight: FontWeight.normal,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
