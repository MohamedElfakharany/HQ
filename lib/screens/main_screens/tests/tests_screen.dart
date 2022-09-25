import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/models/model_test.dart';
import 'package:hq/screens/main_screens/test_items_screen/test_details_screen.dart';
import 'package:hq/screens/main_screens/test_items_screen/test_items_screen.dart';
import 'package:hq/screens/main_screens/widgets_components/widgets_components.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/translations/locale_keys.g.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({Key? key}) : super(key: key);
  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: AppCubit.get(context).tapIndex,
      child: Scaffold(
        backgroundColor: greyExtraLightColor,
        appBar: const GeneralHomeLayoutAppBar(),
        // GeneralAppBar(title: 'Tests Categories',centerTitle: false,appBarColor: greyExtraLightColor,),
        body: Column(
          children: <Widget>[
            // the tab bar with two items
            SizedBox(
              height: 60,
              child: AppBar(
                backgroundColor: greyExtraLightColor,
                elevation: 0.0,
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: blueLightColor, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.15),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                color: whiteColor,
                              ),
                              child: Row(
                                children: [
                                  horizontalMiniSpace,
                                  Image.asset(
                                    'assets/images/logo.png',
                                    fit: BoxFit.cover,
                                    height: 30,
                                    width: 30,
                                  ),
                                  horizontalSmallSpace,
                                  Expanded(
                                    child: Text(
                                      LocaleKeys.homeTxtTestLibrary.tr(),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: darkColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          verticalMicroSpace,
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: blueLightColor, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.15),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                color: whiteColor,
                              ),
                              child: Row(
                                children: [
                                  horizontalMiniSpace,
                                  Image.asset(
                                    'assets/images/logo.png',
                                    fit: BoxFit.cover,
                                    height: 30,
                                    width: 30,
                                  ),
                                  horizontalSmallSpace,
                                  Expanded(
                                    child: Text(
                                      LocaleKeys.homeTxtOffers.tr(),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: darkColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          verticalMicroSpace,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  Column (
                    children: [
                      // verticalSmallSpace,
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      //   child: Container(
                      //     height: 60,
                      //     alignment: AlignmentDirectional.center,
                      //     padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                      //     child: TextFormField(
                      //       controller: searchController,
                      //       keyboardType: TextInputType.text,
                      //       decoration: const InputDecoration(
                      //         prefixIcon: Icon(Icons.search),
                      //         label: Text('Search'),
                      //         hintStyle: TextStyle(color: greyDarkColor, fontSize: 14),
                      //         labelStyle: TextStyle(
                      //           // color: isClickable ? Colors.grey[400] : blueColor,
                      //             color: greyDarkColor,
                      //             fontSize: 14),
                      //         fillColor: Colors.white,
                      //         filled: true,
                      //         errorStyle: TextStyle(color: redColor),
                      //         contentPadding: EdgeInsetsDirectional.only(
                      //             start: 20.0, end: 10.0, bottom: 0.0, top: 0.0),
                      //         border: OutlineInputBorder(
                      //           borderSide: BorderSide(
                      //             width: 1,
                      //             color: greyExtraLightColor,
                      //           ),
                      //         ),
                      //       ),
                      //       style: const TextStyle(
                      //         color: blueLightColor,
                      //         fontSize: 18,
                      //         fontFamily: fontFamily,
                      //       ),
                      //       maxLines: 1,
                      //     ),
                      //   ),
                      // ),
                      verticalSmallSpace,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 20.0,
                            crossAxisSpacing: 20.0,
                            childAspectRatio: 1 / 1,
                            children: List.generate(
                              testsModelData.length,
                              (index) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    FadeRoute(
                                      page: const TestItemsScreen(),
                                    ),
                                  );
                                },
                                child: TestsCard(index: index,),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // second tab bar view widget
                  Column(
                    children: [
                      verticalSmallSpace,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => InkWell(
                              onTap: (){
                                Navigator.push(context, FadeRoute(page: const TestDetailsScreen(),),);
                              },
                              child: OffersCard(index: index,),
                            ),
                            separatorBuilder: (context, index) =>
                                verticalMediumSpace,
                            itemCount: offersModelData.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        // Column(
        //   children: [
        //     // verticalSmallSpace,
        //     Expanded(
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        //         child: GridView.count(
        //           shrinkWrap: true,
        //           physics: const BouncingScrollPhysics(),
        //           crossAxisCount: 2,
        //           mainAxisSpacing: 20.0,
        //           crossAxisSpacing: 20.0,
        //           childAspectRatio: 1 / 1,
        //           children: List.generate(
        //             15,
        //             (index) => InkWell(
        //               onTap: () {
        //                 Navigator.push(
        //                   context,
        //                   FadeRoute(
        //                     page: const TestItemsScreen(),
        //                   ),
        //                 );
        //               },
        //               child: Container(
        //                 height: 110.0,
        //                 width: 110.0,
        //                 decoration: BoxDecoration(
        //                   color: whiteColor,
        //                   borderRadius: BorderRadius.circular(radius),
        //                   border: Border.all(
        //                     width: 1,
        //                     color: greyDarkColor,
        //                   ),
        //                 ),
        //                 alignment: AlignmentDirectional.center,
        //                 padding:
        //                     const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: [
        //                     CachedNetworkImageNormal(
        //                       imageUrl: imageTest,
        //                       width: 100,
        //                       height: 100,
        //                     ),
        //                     verticalSmallSpace,
        //                     const Text(
        //                       'Sugar Text',
        //                       style: titleSmallStyle,
        //                       overflow: TextOverflow.ellipsis,
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
