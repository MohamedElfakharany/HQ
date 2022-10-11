import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/intro_screens/auth/register/select_gender_screen.dart';
import 'package:hq/screens/intro_screens/widget_components.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/cache_helper.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class SelectBranchScreen extends StatelessWidget {
  const SelectBranchScreen(
      {Key? key, required this.countryId, required this.cityId})
      : super(key: key);
  final int countryId;
  final int cityId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: GeneralAppBar(title: ''),
          body: Container(
            color: whiteColor,
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
              child: Column(
                children: [
                  verticalSmallSpace,
                  Text(
                    '${LocaleKeys.BtnSelect.tr()} ${LocaleKeys.txtBranch.tr()}',
                    style: titleStyle.copyWith(fontSize: 30),
                  ),
                  Text(
                    LocaleKeys.onboardingBody.tr(),
                    style: subTitleSmallStyle,
                  ),
                  verticalSmallSpace,
                  LinearProgressIndicator(
                      value: 0.775,
                      backgroundColor: greyLightColor.withOpacity(0.3),
                      color: greenColor),
                  verticalLargeSpace,
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () async {
                          print(
                              'countryId : $countryId cityId : $cityId branchID : $index');
                          await CacheHelper.saveData(
                                  key: 'extraBranchId',
                                  value: cubit.branchModel!.data![index].id)
                              .then(
                            (v) async => {
                              await CacheHelper.saveData(
                                      key: 'extraBranchTitle',
                                      value: AppCubit.get(context)
                                          .branchModel!
                                          .data![index]
                                          .title)
                                  .then((v) => {
                                        Navigator.push(
                                          context,
                                          FadeRoute(
                                            page: SelectGenderScreen(
                                              branchId: index,
                                              countryId: countryId,
                                              cityId: cityId,
                                            ),
                                          ),
                                        ),
                                      })
                            },
                          );
                        },
                        child: RegionCard(
                          title: AppCubit.get(context)
                              .branchModel!
                              .data![index]
                              .title,
                        ),
                      ),
                      separatorBuilder: (context, index) => verticalSmallSpace,
                      itemCount:
                          AppCubit.get(context).branchModel!.data!.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
