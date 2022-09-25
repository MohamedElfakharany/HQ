import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ReadMoreScreen extends StatefulWidget {
  const ReadMoreScreen({Key? key}) : super(key: key);

  @override
  State<ReadMoreScreen> createState() => _ReadMoreScreenState();
}

class _ReadMoreScreenState extends State<ReadMoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(title: LocaleKeys.txtAnalysisPreparations.tr(),),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: ListView(
          children: [
          Image.asset(
          'assets/images/lastOffer.png',
          height: 200,
          width: MediaQuery.of(context).size.width * 0.9,
          ),
            const Text(
              'Glaciated Hemoglobin HBA1C',
              style: titleStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(
              'It includes a set of medical tests that are done periodically (every six months), and they are as follows:It is required to count the two hours from the start of eating and it is required to eat within the first ten minutes from the beginning of the two hours. It is not allowed to eat any food during the two hours. It is only allowed to take water and medication, if available. Please come to the laboratory at least a quarter of an hour before the end of the two hours.',
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
