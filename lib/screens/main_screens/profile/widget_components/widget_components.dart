import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hq/models/profile_models/families_model.dart';
import 'package:hq/screens/main_screens/profile/family/edit_member.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class FamiliesMemberCard extends StatelessWidget {
  FamiliesMemberCard({Key? key, required this.familiesDataModel})
      : super(key: key);
  FamiliesDataModel familiesDataModel;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: CachedNetworkImage(
                      imageUrl: familiesDataModel.profile,
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
                    familiesDataModel.name,
                    style: titleStyle.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.monitor_heart_outlined,
                        color: blueColor,
                      ),
                      horizontalMicroSpace,
                      Text(
                        familiesDataModel.relation!.title,
                        // '',
                        style:
                            subTitleSmallStyle.copyWith(color: blueLightColor),
                      ),
                    ],
                  ),
                  Text(
                    familiesDataModel.gender,
                    style: subTitleSmallStyle,
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      FadeRoute(
                        page: EditMemberScreen(familiesDataModel: familiesDataModel),
                      ),
                    );
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
                          style:
                              subTitleSmallStyle2.copyWith(color: whiteColor),
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
    );
  }
}
