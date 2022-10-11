import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/intro_screens/widget_components.dart';
import 'package:hq/screens/main_screens/home_layout_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/cache_helper.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ProfileChangeBranchScreen extends StatefulWidget {
  const ProfileChangeBranchScreen(
      {Key? key, required this.countryId, required this.cityId})
      : super(key: key);
  final int countryId;
  final int cityId;

  @override
  State<ProfileChangeBranchScreen> createState() =>
      _ProfileChangeBranchScreenState();
}

class _ProfileChangeBranchScreenState extends State<ProfileChangeBranchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getBranch(cityID: widget.cityId),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: GeneralAppBar(title: ''),
            body: Container(
              color: whiteColor,
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 20.0, right: 20.0, left: 20.0),
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
                    verticalLargeSpace,
                    ConditionalBuilder(
                      condition: state is! AppGetBranchesLoadingState,
                      builder: (context) => Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => InkWell(
                            onTap: () async {
                              await CacheHelper.saveData(
                                      key: 'extraBranchId',
                                      value: AppCubit.get(context)
                                          .branchModel!
                                          .data![index]
                                          .id)
                                  .then(
                                (value) async => {
                                  await CacheHelper.saveData(
                                          key: 'extraBranchTitle',
                                          value: AppCubit.get(context)
                                              .branchModel!
                                              .data![index]
                                              .title)
                                      .then(
                                    (value) async => {
                                      await CacheHelper.saveData(
                                        key: 'extraBranchIndexId',
                                        value: index,
                                      ).then(
                                        (v) => {
                                          setState(
                                            () {
                                              cubit.currentIndex = 0;
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  FadeRoute(
                                                      page:
                                                          const HomeLayoutScreen()),
                                                  (route) => false);
                                            },
                                          ),
                                        },
                                      ),
                                    },
                                  ),
                                },
                              );
                            },
                            child: RegionCard(
                              title: cubit.branchModel!.data![index].title,
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              verticalSmallSpace,
                          itemCount: cubit.branchModel?.data?.length ?? 0,
                        ),
                      ),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
