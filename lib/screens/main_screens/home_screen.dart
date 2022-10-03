import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/models/model_test.dart';
import 'package:hq/screens/main_screens/test_items_screen/test_details_screen.dart';
import 'package:hq/screens/main_screens/test_items_screen/test_items_screen.dart';
import 'package:hq/screens/main_screens/widgets_components/widgets_components.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getCountry()
        ..getCity(countryId: extraCountryId!)
        ..getBranch(cityID: extraCityId!)
        ..getCarouselData()
        ..getRelations(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: greyExtraLightColor,
            appBar: const GeneralHomeLayoutAppBar(),
            body: ConditionalBuilder(
              condition: state is! AppGetBranchesLoadingState &&
                  state is! AppGetCarouselLoadingState &&
                  state is! AppGetCitiesLoadingState &&
                  state is! AppGetCountriesLoadingState &&
                  state is! AppGetRelationsLoadingState,
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              // ignore: body_might_complete_normally_nullable
                              validator: (value) {
                                if (value == null) {
                                  return 'Location Required';
                                }
                              },
                              decoration: const InputDecoration(
                                fillColor: greyExtraLightColor,
                                filled: true,
                                errorStyle: TextStyle(color: Color(0xFF4F4F4F)),
                                border: InputBorder.none,
                              ),
                              value: cubit.branchModel?.data?[extraBranchId!]
                                      .title ??
                                  '',
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
                            AppCubit.get(context).changeBottomScreen(1);
                            // Navigator.push(context, FadeRoute(page: const TestsScreen(),),);
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
                                page: const TestItemsScreen(),
                              ),
                            );
                          },
                          child: TestsCard(
                            index: index,
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            horizontalMiniSpace,
                        itemCount: testsModelData.length,
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
                            AppCubit.get(context).changeBottomScreen(1);
                          },
                          child: Text(
                            LocaleKeys.BtnSeeAll.tr(),
                            style: subTitleSmallStyle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
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
                                page: const TestDetailsScreen(),
                              ),
                            );
                          },
                          child: OffersCard(
                            index: index,
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            horizontalMiniSpace,
                        itemCount: offersModelData.length,
                      ),
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
