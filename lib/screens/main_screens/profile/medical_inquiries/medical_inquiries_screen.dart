import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/main_screens/profile/medical_inquiries/inquiry_screen.dart';
import 'package:hq/screens/main_screens/profile/medical_inquiries/new_inquiry.dart';
import 'package:hq/screens/main_screens/profile/widget_components/widget_components.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class MedicalInquiriesScreen extends StatefulWidget {
  const MedicalInquiriesScreen({Key? key}) : super(key: key);

  @override
  State<MedicalInquiriesScreen> createState() => _MedicalInquiriesScreenState();
}

class _MedicalInquiriesScreenState extends State<MedicalInquiriesScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 0),
      () async {
        AppCubit.get(context).getMedicalInquiries();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: greyExtraLightColor,
          appBar: GeneralAppBar(
            title: LocaleKeys.txtMedicalInquiries.tr(),
            appBarColor: greyExtraLightColor,
            centerTitle: false,
          ),
          body: Padding(
            padding:
                const EdgeInsets.only(right: 20.0, bottom: 20.0, left: 20.0),
            child: Column(
              children: [
                GeneralButton(
                  title: LocaleKeys.txtNewInquiries.tr(),
                  onPress: () {
                    Navigator.push(context, FadeRoute(page: const NewInquiryScreen()));
                  },
                ),
                verticalMediumSpace,
                ConditionalBuilder(
                  condition: state is! AppGetMedicalInquiriesLoadingState,
                  builder: (context) => Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            FadeRoute(
                              page: InquiryScreen(
                                medicalInquiriesDataModel: AppCubit.get(context)
                                    .medicalInquiriesModel!
                                    .data![index],
                              ),
                            ),
                          );
                        },
                        child: MedicalInquiriesCard(
                          medicalInquiriesDataModel: AppCubit.get(context)
                              .medicalInquiriesModel!
                              .data![index],
                        ),
                      ),
                      separatorBuilder: (context, index) => verticalSmallSpace,
                      itemCount: AppCubit.get(context)
                              .medicalInquiriesModel
                              ?.data
                              ?.length ??
                          0,
                    ),
                  ),
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
