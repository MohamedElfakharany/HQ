import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyExtraLightColor,
      appBar: GeneralAppBar(
        title: LocaleKeys.txtMedicalInquiries.tr(),
        appBarColor: greyExtraLightColor,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, bottom: 20.0, left: 20.0),
        child: Column(
          children: [
            GeneralButton(title: LocaleKeys.txtNewInquiries.tr(), onPress: (){},),
            verticalMediumSpace,
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(
                      radius,
                    ),
                    border: Border.all(
                      width: 1,
                      color: greyLightColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: blueLightColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(
                              radius,
                            ),
                          ),
                          child: const Icon(
                            Icons.notifications_rounded,
                            size: 35.0,
                            color: blueColor,
                          ),
                        ),
                        horizontalSmallSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '2h 17min ago',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: subTitleSmallStyle,
                              ),
                            ],
                          ),
                        ),
                        horizontalSmallSpace,
                        if (index == 0 || index ==1 )
                          Container(
                            width: 60.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                              color: greenColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(
                                radius,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'New',
                                style: titleSmallStyleGreen,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => verticalSmallSpace,
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
