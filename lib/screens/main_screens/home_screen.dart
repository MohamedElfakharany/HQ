import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/main_screens/home_layout_screen.dart';
import 'package:hq/screens/main_screens/test_items_screen/test_details_screen.dart';
import 'package:hq/screens/main_screens/test_items_screen/test_items_screen.dart';
import 'package:hq/screens/main_screens/widgets_components/widgets_components.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/cache_helper.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchController = TextEditingController();

  String? locationValue;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 0),
          () {
        AppCubit.get(context).getProfile();
        AppCubit.get(context).getTerms();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    extraBranchTitle = CacheHelper.getData(key: 'extraBranchTitle');
    extraBranchIndexId = CacheHelper.getData(key: 'extraBranchIndexId');
    extraCityId = CacheHelper.getData(key: 'extraCityId');
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getCountry()
        ..getCity(countryId: extraCityId!)
        ..getBranch(cityID: extraCityId!)
        ..getCarouselData()
        ..getRelations()
        ..getCategories()
        ..getOffers()
        ..getProfile()
        ..getTerms(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: greyExtraLightColor,
            body: ConditionalBuilder(
              condition: state is! AppGetBranchesLoadingState &&
                  state is! AppGetCarouselLoadingState &&
                  state is! AppGetCitiesLoadingState &&
                  state is! AppGetCountriesLoadingState &&
                  state is! AppGetRelationsLoadingState &&
                  state is! AppGetCategoriesLoadingState &&
                  state is! AppGetOffersLoadingState &&
                  state is! AppGetTestsLoadingState &&
                  state is! AppGetProfileLoadingState,
              builder: (context) => Container(
                color: greyExtraLightColor,
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: greyDarkColor,
                        ),
                        horizontalMiniSpace,
                        Text(
                          '${LocaleKeys.txtBranch.tr()} : ',
                          style: titleSmallStyle,
                        ),
                        Expanded(
                          child:
                              // DropdownButtonHideUnderline(
                              //   child: DropdownButtonFormField<String>(
                              //     validator: (value) {
                              //       if (value == null) {
                              //         return LocaleKeys.txtTestName.tr();
                              //       }
                              //     },
                              //     decoration: InputDecoration(
                              //       fillColor: Colors.white,
                              //       filled: true,
                              //       contentPadding:
                              //       const EdgeInsetsDirectional.only(
                              //           start: 20.0, end: 10.0),
                              //       errorStyle: const TextStyle(
                              //           color: Color(0xFF4F4F4F)),
                              //       label: Text(LocaleKeys.txtTestName.tr()),
                              //       border: const OutlineInputBorder(
                              //         borderSide: BorderSide(
                              //           width: 2,
                              //           color: blueColor,
                              //         ),
                              //       ),
                              //     ),
                              //     value: cubit.branchName.first,
                              //     isExpanded: true,
                              //     iconSize: 35,
                              //     items: cubit.branchName
                              //         .map(buildLocationItem)
                              //         .toList(),
                              //     onChanged: (value) => setState(() => locationValue = value),
                              //   ),
                              // ),
                              DropdownButtonHideUnderline(
                            child: ConditionalBuilder(
                              condition: state is! AppGetBranchesLoadingState &&
                                  state is! AppGetCitiesLoadingState &&
                                  state is! AppGetCountriesLoadingState &&
                                  cubit.branchNames != null,
                              builder: (context) =>
                                  DropdownButtonFormField<String>(
                                // ignore: body_might_complete_normally_nullable
                                validator: (value) {
                                  if (value == null) {
                                    return 'Location Required';
                                  }
                                },
                                decoration: const InputDecoration(
                                  fillColor: greyExtraLightColor,
                                  filled: true,
                                  errorStyle:
                                      TextStyle(color: Color(0xFF4F4F4F)),
                                  border: InputBorder.none,
                                ),
                                value: extraBranchTitle,
                                isExpanded: true,
                                iconSize: 30,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: greyDarkColor,
                                ),
                                items: cubit.branchName
                                    .map(buildLocationItem)
                                    .toList(),
                                onChanged: (value) =>
                                    setState(() => locationValue = value),
                                onSaved: (v) {
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                              fallback: (context) => const Center(
                                  child: LinearProgressIndicator()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSmallSpace,
                    ConditionalBuilder(
                      condition: cubit.carouselModel?.data != null,
                      builder: (context) => CarouselSlider(
                        items: cubit.carouselModel?.data!
                            .map(
                              (e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radius),
                                    color: whiteColor,
                                    border: Border.all(color: greyLightColor),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          e.image,
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        verticalMiniSpace,
                                        Text(
                                          e.title,
                                          style: titleSmallStyleRed.copyWith(
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Text(
                                            e.text,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: titleSmallStyle2,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '',
                                              style: titleSmallStyle.copyWith(
                                                color: blueColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Image.asset(e.image)
                              //         CachedNetworkImage(
                              //   imageUrl: e.image,
                              //   placeholder: (context, url) => SizedBox(
                              //     child: Center(child: CircularProgressIndicator()),
                              //     width: 60,
                              //     height: 60,
                              //   ),
                              //   errorWidget: (context, url, error) => Icon(Icons.error),
                              // ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          height: 150.0,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(seconds: 1),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                          viewportFraction: 1.0,
                          onPageChanged: (int index, reason) {
                            AppCubit.get(context).changeCarouselState(index);
                          },
                        ),
                      ),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    verticalMediumSpace,
                    Row(
                      children: [
                        Text(LocaleKeys.txtTestCategories.tr(),
                            style: titleStyle),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            cubit.changeBottomScreen(1);
                            Navigator.pushAndRemoveUntil(
                                context,
                                FadeRoute(page: const HomeLayoutScreen()),
                                (route) => false);
                          },
                          child: Text(
                            LocaleKeys.BtnSeeAll.tr(),
                            style: subTitleSmallStyle,
                          ),
                        ),
                      ],
                    ),
                    verticalMiniSpace,
                    SizedBox(
                      height: 110.0,
                      width: double.infinity,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              FadeRoute(
                                page: TestItemsScreen(
                                    categoryId: AppCubit.get(context)
                                        .categoriesModel!
                                        .data![index]
                                        .id),
                              ),
                            );
                          },
                          child: CategoriesCard(
                            categoriesDataModel: AppCubit.get(context)
                                .categoriesModel!
                                .data![index],
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            horizontalMiniSpace,
                        itemCount: AppCubit.get(context)
                                .categoriesModel
                                ?.data
                                ?.length ??
                            0,
                      ),
                    ),
                    verticalMediumSpace,
                    Row(
                      children: [
                        Text(LocaleKeys.homeTxtOffers.tr(), style: titleStyle),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            AppCubit.get(context).fromHome = true;
                            cubit.changeBottomScreen(1);
                            Navigator.pushAndRemoveUntil(
                                context,
                                FadeRoute(page: const HomeLayoutScreen()),
                                (route) => false);
                          },
                          child: Text(
                            LocaleKeys.BtnSeeAll.tr(),
                            style: subTitleSmallStyle,
                          ),
                        ),
                      ],
                    ),
                    ConditionalBuilder(
                      condition: cubit.offersModel?.data != null,
                      builder: (context) => SizedBox(
                        height: 235.0,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                FadeRoute(
                                  page: TestDetailsScreen(
                                    offersDataModel: AppCubit.get(context)
                                        .offersModel!
                                        .data![index],
                                  ),
                                ),
                              );
                            },
                            child: OffersCard(
                              offersDataModel: AppCubit.get(context)
                                  .offersModel!
                                  .data![index],
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              horizontalMiniSpace,
                          itemCount:
                              AppCubit.get(context).offersModel!.data!.length,
                        ),
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    verticalMiniSpace,
                  ],
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }

  DropdownMenuItem<String> buildLocationItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}
