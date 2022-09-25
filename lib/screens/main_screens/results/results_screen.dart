import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/main_screens/profile/region_settings/change_language.dart';
import 'package:hq/screens/main_screens/results/result_details.dart';
import 'package:hq/shared/components/cached_network_image.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (kDebugMode) {
          print('isVisitor ${AppCubit.get(context).isVisitor}');
        }
        return Scaffold(
          backgroundColor: greyExtraLightColor,
          appBar: const GeneralHomeLayoutAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (AppCubit.get(context).isVisitor == true)
                  const Expanded(
                    child: VisitorHolderScreen(),
                  ),
                if (AppCubit.get(context).isVisitor == false)
                  Text(
                    LocaleKeys.BtnResult.tr(),
                    style: titleStyle,
                  ),
                if (AppCubit.get(context).isVisitor == false)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 4),
                      child: TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          label: Text(
                            LocaleKeys.TxtFieldSearch.tr(),
                          ),
                          hintStyle: const TextStyle(
                              color: greyDarkColor, fontSize: 14),
                          labelStyle: const TextStyle(
                            // color: isClickable ? Colors.grey[400] : blueColor,
                            color: greyDarkColor,
                            fontSize: 14,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          errorStyle: const TextStyle(color: redColor),
                          contentPadding: const EdgeInsetsDirectional.only(
                              start: 20.0, end: 10.0, bottom: 15.0, top: 15.0),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: greyExtraLightColor,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          color: blueLightColor,
                          fontSize: 18,
                          fontFamily: fontFamily,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                if (AppCubit.get(context).isVisitor == false)
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            FadeRoute(
                              page: const ResultDetailsScreen(),
                            ),
                          );
                        },
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 4),
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Row(
                                children: [
                                  horizontalMicroSpace,
                                  CachedNetworkImageNormal(
                                    imageUrl: imageTest,
                                    width: 80,
                                    height: 80,
                                  ),
                                  horizontalSmallSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '#150-450-600',
                                          style: titleSmallStyle,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Text(
                                          'Tests Results (06)',
                                          style: subTitleSmallStyle2,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '80 ${LocaleKeys.salary.tr()}',
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
                      itemCount: 13,
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
