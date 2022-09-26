// ignore_for_file: body_might_complete_normally_nullable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/main_screens/profile/address_screen/map_screen.dart';
import 'package:hq/screens/main_screens/reservations/reservation_overview.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ReservationDetailsScreen extends StatefulWidget {
  const ReservationDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ReservationDetailsScreen> createState() =>
      _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen> {
  final memberItems = [
    'Mohamed (Me)',
    'Ahmed (Son)',
    'salim (Father)',
    'omar (brother)',
  ];
  String? memberValue;
  final locationItems = [
    'Riyadh , Abdallah St 1',
    'Riyadh , King tower St 2',
    'Riyadh , Abdallah St 3',
    'Riyadh , Abdallah St 4',
  ];
  String? locationValue;
  final branchItems = [
    '${LocaleKeys.txtBranch.tr()} 1',
    '${LocaleKeys.txtBranch.tr()} 2',
    '${LocaleKeys.txtBranch.tr()} 3',
    '${LocaleKeys.txtBranch.tr()} 4'
  ];
  String? branchValue;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.txtPatient.tr(),
                  style: titleStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                verticalMiniSpace,
                if (AppCubit.get(context).isVisitor == true)
                  Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    alignment: AlignmentDirectional.center,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.perm_identity_rounded,
                            color: greyLightColor,
                            size: 30,
                          ),
                          horizontalMiniSpace,
                          Text(
                            LocaleKeys.txtPatient.tr(),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (AppCubit.get(context).isVisitor == false)
                  Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    alignment: AlignmentDirectional.center,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null) {
                            return 'Relation Required';
                          }
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.perm_identity_rounded,
                            color: greyLightColor,
                            size: 30,
                          ),
                          contentPadding: EdgeInsetsDirectional.only(
                            start: 20.0,
                            end: 0.0,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          errorStyle: TextStyle(color: Color(0xFF4F4F4F)),
                          border: InputBorder.none,
                        ),
                        value: memberItems.first,
                        isExpanded: true,
                        iconSize: 30,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: blueColor,
                        ),
                        items: memberItems.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => memberValue = value),
                        onSaved: (v) {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                  ),
                verticalMiniSpace,
                Text(
                  LocaleKeys.TxtPopUpReservationType.tr(),
                  style: titleStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                verticalMiniSpace,
                Container(
                  height: 150.0,
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
                            Text(
                              LocaleKeys.BtnAtLab.tr(),
                              style: titleSmallStyle.copyWith(color: blueColor),
                            ),
                            const Spacer(),
                            Image.asset('assets/images/atLabIcon.png',
                                height: 30, width: 20, color: greyDarkColor),
                            horizontalSmallSpace,
                          ],
                        ),
                      ),
                      myHorizontalDivider(),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            validator: (value) {
                              if (value == null) {
                                return 'Location Required';
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.location_on_rounded,
                                color: greyLightColor,
                                size: 30,
                              ),
                              contentPadding: const EdgeInsetsDirectional.only(
                                  start: 20.0, end: 0.0, bottom: 15.0),
                              fillColor: Colors.white,
                              filled: true,
                              errorStyle:
                                  const TextStyle(color: Color(0xFF4F4F4F)),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    FadeRoute(
                                      page: MapScreen(),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.add_location_alt_outlined,
                                  color: blueColor,
                                ),
                              ),
                            ),
                            value: locationItems.first,
                            isExpanded: true,
                            iconSize: 30,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: blueColor,
                            ),
                            items:
                                locationItems.map(buildLocationItem).toList(),
                            onChanged: (value) =>
                                setState(() => locationValue = value),
                            onSaved: (v) {
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        ),
                      ),
                      myHorizontalDivider(),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            validator: (value) {
                              if (value == null) {
                                return 'Location Required';
                              }
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.location_on_rounded,
                                color: greyLightColor,
                                size: 30,
                              ),
                              contentPadding: EdgeInsetsDirectional.only(
                                  start: 20.0, end: 0.0, bottom: 5.0),
                              fillColor: Colors.white,
                              filled: true,
                              errorStyle: TextStyle(color: Color(0xFF4F4F4F)),
                              border: InputBorder.none,
                              suffixIcon: Text(''),
                            ),
                            value: branchItems.first,
                            isExpanded: true,
                            iconSize: 30,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: blueColor,
                            ),
                            items: branchItems.map(buildLocationItem).toList(),
                            onChanged: (value) =>
                                setState(() => branchValue = value),
                            onSaved: (v) {
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      FadeRoute(
                        page: const ReservationOverviewScreen(),
                      ),
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
                      LocaleKeys.BtnContinue.tr(),
                      style: titleStyle.copyWith(
                          fontSize: 20.0,
                          color: whiteColor,
                          fontWeight: FontWeight.normal),
                    )),
                  ),
                ),
                verticalMiniSpace,
              ],
            ),
          ),
        );
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Row(
          children: [
            Text(item),
          ],
        ),
      );

  DropdownMenuItem<String> buildLocationItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}
