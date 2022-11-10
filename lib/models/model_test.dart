import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/translations/locale_keys.g.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SyncfusionFlutterDatePicker extends StatefulWidget {
  const SyncfusionFlutterDatePicker({super.key});

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
