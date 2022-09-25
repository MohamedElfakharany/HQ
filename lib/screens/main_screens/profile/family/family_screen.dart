import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hq/screens/main_screens/profile/family/edit_member.dart';
import 'package:hq/screens/main_screens/profile/family/new_member.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyExtraLightColor,
      appBar: GeneralAppBar(
        title: LocaleKeys.txtFamily.tr(),
        appBarColor: greyExtraLightColor,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, FadeRoute(page: const NewMemberScreen(),),);
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
                    LocaleKeys.txtNewMember.tr(),
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
                itemBuilder: (context,index) => Container(
                  width: double.infinity,
                  height: 147,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(width: 1, color: greyDarkColor),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40.0),
                                child: CachedNetworkImage(
                                  imageUrl: imageTest,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) => const SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                          color: blueColor,
                                        )),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: whiteColor),
                                    child: const Icon(
                                      Icons.perm_identity,
                                      size: 100,
                                      color: blueColor,
                                    ),
                                  ),
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              Text(
                                'Mohamed Elfakharany',
                                style: titleStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(children: [
                                const Icon(Icons.heart_broken,color: blueColor,),
                                horizontalMicroSpace,
                                Text('Brother ${index  + 1}',style: subTitleSmallStyle.copyWith(color: blueLightColor),),
                              ],),
                              const Text('Male',style: subTitleSmallStyle,),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, FadeRoute(page: const EditMemberScreen(),),);
                              },
                              child: Container(
                                height: 35,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: blueColor,
                                  borderRadius: BorderRadius.circular(radius),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.edit,
                                      color: whiteColor,
                                    ),
                                    horizontalMicroSpace,
                                    Text(
                                      LocaleKeys.txtEdit.tr(),
                                      style: subTitleSmallStyle2.copyWith(
                                          color: whiteColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context,index) => verticalMediumSpace,
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
