import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hq/screens/main_screens/profile/address_screen/map_screen.dart';
import 'package:hq/screens/main_screens/profile/family/new_member.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyExtraLightColor,
      appBar: GeneralAppBar(
        title: LocaleKeys.txtAddress.tr(),
        appBarColor: greyExtraLightColor,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, FadeRoute(page: MapScreen(),),);
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: Center(
                  child: Text(
                    LocaleKeys.txtNewAddress.tr(),
                    style: titleSmallStyle.copyWith(
                      color: whiteColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
            verticalMediumSpace,
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(width: 1, color: greyDarkColor),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  if (index == 0)
                                  SvgPicture.asset(
                                    'assets/images/checkTrue.svg',
                                    width: 20,
                                    height: 20,
                                  ),
                                  if(index > 0)
                                    const Icon(Icons.adjust_rounded,size: 20,color: greyDarkColor,),
                                  horizontalSmallSpace,
                                  Text(
                                    'Riyadh, Abdullah King St 306',
                                    style: titleSmallStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.location_on_rounded,
                                    color: greyDarkColor,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 35,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: blueColor,
                                    borderRadius:
                                        BorderRadius.circular(radius),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.edit,
                                        color: whiteColor,
                                      ),
                                      horizontalMicroSpace,
                                      Text(
                                        'Edit',
                                        style: subTitleSmallStyle2.copyWith(
                                            color: whiteColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => verticalMediumSpace,
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
