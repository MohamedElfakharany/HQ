// class OffersModel {
//   final String title;
//   final String image;
//   final String body;
//   final String price;
//   final String discount;
//   final String percent;
//   final String gender;
//
//   OffersModel({
//     required this.title,
//     required this.price,
//     required this.discount,
//     required this.percent,
//     required this.gender,
//     required this.body,
//     required this.image,
//   });
// }
//
// List<OffersModel> offersModelDataxx = [
//
//   OffersModel(
//     image:
//     'https://lmg-labmanager.s3.amazonaws.com/assets/articleNo/27442/aImg/50021/lab-quality-assurance-l.jpg',
//     body:
//     'Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. 6',
//     price: '600',
//     discount: '450',
//     percent: '25',
//     gender: 'none',
//     title: 'title 7',
//   ),
//   OffersModel(
//     image:
//         'https://www.eduwaves.org/wp-content/uploads/2018/10/laboratory-tests.jpg',
//     body:
//         'Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. 1',
//     price: '200',
//     discount: '150',
//     percent: '25',
//     gender: 'male',
//     title: 'title 1',
//   ),
//   OffersModel(
//     image:
//         'https://cdn.dnaindia.com/sites/default/files/styles/full/public/2018/12/24/769065-laboratory-tests-shutterstock-122418.jpg',
//     body:
//         'Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. 2',
//     price: '250',
//     discount: '200',
//     percent: '20',
//     gender: 'female',
//     title: 'title 2',
//   ),
//   OffersModel(
//     image:
//         'https://www.medgadget.com/wp-content/uploads/2020/10/Clinical-Laboratory-Test-Market.jpg',
//     body:
//         'Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. 3',
//     price: '300',
//     discount: '200',
//     percent: '33',
//     gender: 'male',
//     title: 'title 3',
//   ),
//   OffersModel(
//     image:
//         'https://assets.technologynetworks.com/production/dynamic/images/content/337594/breakthrough-new-blood-test-detects-positive-covid-19-result-in-20-minutes-337594-640x360.jpg',
//     body:
//         'Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. 4',
//     price: '100',
//     discount: '50',
//     percent: '50',
//     gender: 'female',
//     title: 'title 4',
//   ),
//   OffersModel(
//     image:
//         'https://www.adventhealth.com/sites/default/files/styles/og_image/public/media/lab_work.jpg',
//     body:
//         'Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. 5',
//     price: '500',
//     discount: '400',
//     percent: '20',
//     gender: 'male',
//     title: 'title 5',
//   ),
//   OffersModel(
//     image:
//         'https://lmg-labmanager.s3.amazonaws.com/assets/articleNo/27442/aImg/50021/lab-quality-assurance-l.jpg',
//     body:
//         'Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. 6',
//     price: '600',
//     discount: '450',
//     percent: '25',
//     gender: 'male',
//     title: 'title 6',
//   ),
// ];

// ////////////////////////////////////////////////////////////////////////
//
// class TestsModelxx {
//   final String image;
//   final String body;
//
//   TestsModelxx({
//     required this.image,
//     required this.body,
//   });
// }
//
// List<TestsModelxx> testsModelData = [
//   TestsModelxx(
//     image: 'assets/images/sugarCheck.png',
//     body: 'Sugar Checks',
//   ),
//   TestsModelxx(
//     image: 'assets/images/urineTest.png',
//     body: 'Urine Test',
//   ),
//   TestsModelxx(
//     image: 'assets/images/liverTest.png',
//     body: 'Liver Test',
//   ),
//   TestsModelxx(
//     image: 'assets/images/allergyTest.png',
//     body: 'Allergy Test',
//   ),
//   TestsModelxx(
//     image: 'assets/images/immuneDiseases.png',
//     body: 'Immune Diseases',
//   ),
//   TestsModelxx(
//     image: 'assets/images/geneticsAnalysis.png',
//     body: 'genetics analysis',
//   ),
//   TestsModelxx(
//     image: 'assets/images/bloodFats.png',
//     body: 'Blood Fats',
//   ),
//   TestsModelxx(
//     image: 'assets/images/hormones.png',
//     body: 'Hormones',
//   ),
// ];

// ignore_for_file: use_key_in_widget_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/translations/locale_keys.g.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SyncfusionFlutterDatePicker extends StatefulWidget {
  @override
  SyncfusionFlutterDatePickerState createState() =>
      SyncfusionFlutterDatePickerState();
}

/// State for SyncfusionFlutterDatePicker
class SyncfusionFlutterDatePickerState
    extends State<SyncfusionFlutterDatePicker> {
  String selectedDate = '';

  String dateCount = '';

  String rangeCount = '';

  String range = '';

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        dateCount = args.value.length.toString();
      } else {
        rangeCount = args.value.length.toString();
      }
      print(range);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(
                Icons.close,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Date Range',
                    style: titleSmallStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(range),
        SfDateRangePicker(
          onSelectionChanged: onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,
          initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 3))),
        ),
        GeneralButton(
          title: LocaleKeys.BtnSubmit.tr(),
          onPress: () {
            showToast(msg: range,state: ToastState.success);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
