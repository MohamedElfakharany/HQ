// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/models/lab_appointments_model/lab_appointment_model.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';

class LabAppointmentsCard extends StatelessWidget {
  LabAppointmentsCard({Key? key, this.labAppointmentsDataModel})
      : super(key: key);

  LabAppointmentsDataModel? labAppointmentsDataModel;

  @override
  Widget build(BuildContext context) {
    Color cardBgColor;
    Color fontColor;
    if (labAppointmentsDataModel?.isUsed){
      cardBgColor = whiteColor;
      fontColor = darkColor;
    }else {
      cardBgColor = greyLightColor.withOpacity(0.2);
      fontColor = greyDarkColor;
    }
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: 40.0,
          decoration: BoxDecoration(
            color: cardBgColor,
            borderRadius: BorderRadius.circular(radius),
          ),
          alignment: AlignmentDirectional.center,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
          child: Text(
            labAppointmentsDataModel?.time,
            textAlign: TextAlign.center,
            style: titleSmallStyle.copyWith(color: fontColor),
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
