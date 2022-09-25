import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/shared/components/cached_network_image.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ResultDetailsScreen extends StatefulWidget {
  const ResultDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ResultDetailsScreen> createState() => _ResultDetailsScreenState();
}

class _ResultDetailsScreenState extends State<ResultDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: greyExtraLightColor,
          appBar: GeneralAppBar(
            title: '${LocaleKeys.TxtTestResult.tr()} (04)',
            appBarColor: greyExtraLightColor,
            centerTitle: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 70,
                    alignment: AlignmentDirectional.center,
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
                    padding:
                        const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: const [
                              Text(
                                '#150-450-600',
                                style: titleSmallStyle,
                                textAlign: TextAlign.start,
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            '24 Feb 2022',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 110.0,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  alignment: AlignmentDirectional.center,
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      horizontalMiniSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalMiniSpace,
                            Row(
                              children: [
                                const Icon(Icons.info,color: blueColor,),
                                horizontalMicroSpace,
                                Text(
                                  'Notes',
                                  maxLines: 2,
                                  style: titleSmallStyle.copyWith(color: blueColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            verticalMiniSpace,
                            const Text(
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                              style: TextStyle(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                verticalMiniSpace,
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => InkWell(
                      onTap: (){},
                      child: Container(
                        height: 110.0,
                        width: 110.0,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(radius),
                          border: Border.all(
                            width: 1,
                            color: greyLightColor,
                          ),
                        ),
                        alignment: AlignmentDirectional.center,
                        padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Row(
                              children: [
                                horizontalMicroSpace,
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset('assets/images/pdf.jpg'),
                                ),
                                horizontalSmallSpace,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        '#150-450-600',
                                        style: titleSmallStyle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Tests Results (06)',
                                        style: subTitleSmallStyle2,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '80 SAR',
                                        style: titleSmallStyle2,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => verticalMiniSpace,
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
