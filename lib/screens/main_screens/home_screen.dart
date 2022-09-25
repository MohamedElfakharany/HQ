import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/models/model_test.dart';
import 'package:hq/screens/intro_screens/startup/onboarding_screen.dart';
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
  List<BoardingModel> banner = [
    BoardingModel(
      image: 'assets/images/offerImage.png',
      body:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. 1',
      title: 'discount title 1',
    ),
    BoardingModel(
      image: 'assets/images/offerImage.png',
      body:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. 2',
      title: 'discount title 2',
    ),
    BoardingModel(
      image: 'assets/images/offerImage.png',
      body:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. 3',
      title: 'discount title 3',
    ),
  ];

  final locationItems = [
    'Riyadh , Abdallah St 1',
    'Riyadh , Abdallah St 2',
    'Riyadh , Abdallah St 3',
    'Riyadh , Abdallah St 4',
  ];
  String? locationValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralHomeLayoutAppBar(),
      body: Container(
        color: greyExtraLightColor,
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
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
                      value: locationItems.first,
                      isExpanded: true,
                      iconSize: 30,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: greyDarkColor,
                      ),
                      items: locationItems.map(buildLocationItem).toList(),
                      onChanged: (value) =>
                          setState(() => locationValue = value),
                      onSaved: (v) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                  // Row(
                  //   children: const [
                  //     horizontalMicroSpace,
                  //     Icon(Icons.location_on_rounded,),
                  //     horizontalMicroSpace,
                  //     Expanded(
                  //       child: Text(
                  //         textAlign: TextAlign.start,
                  //         'Riyadh , King St 7034 ...',
                  //         style: titleSmallStyle,
                  //         maxLines: 1,
                  //         overflow: TextOverflow.ellipsis,
                  //       ),
                  //     ),
                  //     Icon(Icons.arrow_forward_ios_sharp,),
                  //     horizontalMicroSpace,
                  //   ],
                  // ),
                ),
              ],
            ),
            // Container(
            //   alignment: AlignmentDirectional.center,
            //   padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
            //   height: 60,
            //   child: TextFormField(
            //     controller: searchController,
            //     keyboardType: TextInputType.none,
            //     readOnly: true,
            //     onTap: (){
            //       Navigator.push(context, FadeRoute(page: const SearchScreen(),),);
            //     },
            //     decoration: const InputDecoration(
            //       prefixIcon: Icon(Icons.search),
            //       label: Text('Search'),
            //       hintText: 'search',
            //       hintStyle: TextStyle(color: greyDarkColor, fontSize: 14),
            //       labelStyle: TextStyle(
            //           // color: isClickable ? Colors.grey[400] : blueColor,
            //           color: greyDarkColor,
            //           fontSize: 14),
            //       fillColor: Colors.white,
            //       filled: true,
            //       errorStyle: TextStyle(color: redColor),
            //       contentPadding: EdgeInsetsDirectional.only(
            //           start: 20.0, end: 10.0, bottom: 0.0, top: 0.0),
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(
            //           width: 1,
            //           color: greyExtraLightColor,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            verticalSmallSpace,
            CarouselSlider(
              items: banner
                  .map(
                    (e) => Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        color: whiteColor,
                        border: Border.all(color: greyLightColor),
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Image.asset(
                            e.image,
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                verticalMiniSpace,
                                Text(
                                  e.title,
                                  style:
                                      titleSmallStyleRed.copyWith(fontSize: 20),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    e.body,
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
                        ],
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
            verticalMediumSpace,
            Row(
              children: [
                Text(LocaleKeys.txtTestCategories.tr(), style: titleStyle),
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
                separatorBuilder: (context, index) => horizontalMiniSpace,
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
                        page: const TestItemsScreen(),
                      ),
                    );
                  },
                  child: OffersCard(
                    index: index,
                  ),
                ),
                separatorBuilder: (context, index) => horizontalMiniSpace,
                itemCount: offersModelData.length,
              ),
            ),
            verticalMiniSpace,
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildLocationItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}
