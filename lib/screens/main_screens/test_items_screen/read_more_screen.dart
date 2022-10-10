import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hq/models/test_models/offers_model.dart';
import 'package:hq/models/test_models/tests_model.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ReadMoreScreen extends StatelessWidget {
  ReadMoreScreen({Key? key, this.testsDataModel, this.offersDataModel}) : super(key: key);
  TestsDataModel? testsDataModel;
  OffersDataModel? offersDataModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(title: LocaleKeys.txtAnalysisPreparations.tr(),),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: ListView(
          children: [
          CachedNetworkImage(
            imageUrl: testsDataModel?.image ?? offersDataModel?.image,
            height: 200,
            width: MediaQuery.of(context).size.width * 0.9,
            fit: BoxFit.cover,
          ),
            Text(
              testsDataModel?.title ?? offersDataModel?.title,
              style: titleStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              testsDataModel?.description ?? offersDataModel?.description,
              style: subTitleSmallStyle.copyWith(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
