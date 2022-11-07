// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:hq/shared/components/cached_network_image.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/tech_lib/tech_cubit/tech_cubit.dart';
import 'package:hq/tech_lib/tech_cubit/tech_states.dart';
import 'package:hq/translations/locale_keys.g.dart';

class TechReservationsDetailsScreen extends StatefulWidget {
  const TechReservationsDetailsScreen({Key? key})
      : super(key: key);

  @override
  State<TechReservationsDetailsScreen> createState() => _TechReservationsDetailsScreenState();
}

class _TechReservationsDetailsScreenState extends State<TechReservationsDetailsScreen> {
  var couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppTechCubit, AppTechStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: greyExtraLightColor,
          appBar: GeneralAppBar(
            title: LocaleKeys.txtReservationDetails.tr(),
            centerTitle: false,
            appBarColor: greyExtraLightColor,
          ),
          body: Padding(
            padding:
            const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 120 * 4,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => SwipeActionCell(
                      // key: ValueKey(AppCubit.get(context)
                      //     .medicalInquiriesModel!
                      //     .data![index]),
                      key: const ValueKey(1),
                      trailingActions: [
                        SwipeAction(
                          nestedAction: SwipeNestedAction(
                            /// customize your nested action content
                            content: ConditionalBuilder(
                              condition: true,
                              builder: (context) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.red,
                                ),
                                width: 130,
                                height: 60,
                                child: OverflowBox(
                                  maxWidth: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      Text(LocaleKeys.BtnDelete.tr(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                    ],
                                  ),
                                ),
                              ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                          ),

                          /// you should set the default  bg color to transparent
                          color: Colors.transparent,

                          /// set content instead of title of icon
                          content: _getIconButton(Colors.red, Icons.delete),
                          onTap: (handler) async {
                            // AppCubit.get(context).deleteInquiry(
                            //   inquiryId: AppCubit.get(context)
                            //       .medicalInquiriesModel!
                            //       .data![index]
                            //       .id,
                            // );
                          },
                        ),
                      ],
                      child: Container(
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
                                  imageUrl: imageTest,
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
                                      const Text(
                                        'Glaciated Hemoglobin HBA1C',
                                        style: titleSmallStyle,
                                        maxLines: 1,
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
                    ),
                    separatorBuilder: (context, index) => verticalMiniSpace,
                    itemCount: 4,
                  ),
                ),
                Text(
                  LocaleKeys.txtReservationDetails.tr(),
                  style: titleStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                verticalMiniSpace,
                Container(
                  height: 236.0,
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
                                  const Text(
                                    'Mohammed',
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
                            const Icon(
                              Icons.location_on_rounded,
                              color: mainColor,
                            ),
                            myVerticalDivider(),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Location',
                                    style: titleStyle.copyWith(
                                        color: greyLightColor),
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Riyadh , King St 7034',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          showToast(msg: '7mada',state: ToastState.success);
                                        },
                                        child: Text(
                                          'Show Map',
                                          style: titleSmallStyle2.copyWith(decoration: TextDecoration.underline,color: mainColor),
                                        ),
                                      ),
                                      horizontalSmallSpace,
                                    ],
                                  ),
                                ],
                              ),
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
                              'assets/images/reservedSelected.png',
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
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getIconButton(color, icon) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        /// set you real bg color in your content
        color: color,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}