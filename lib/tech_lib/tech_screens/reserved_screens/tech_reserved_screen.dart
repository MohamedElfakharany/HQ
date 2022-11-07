import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hq/models/model_test.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/tech_lib/tech_components.dart';
import 'package:hq/translations/locale_keys.g.dart';

class TechReservedScreen extends StatelessWidget {
  const TechReservedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyExtraLightColor,
      appBar: const TechGeneralHomeLayoutAppBar(),
      body: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: greyExtraLightColor,
          body: Column(
            children: <Widget>[
              // the tab bar with two items
              Container(
                height: 58,
                decoration: const BoxDecoration(color: greyExtraLightColor),
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: AppBar(
                  backgroundColor: greyExtraLightColor,
                  elevation: 0.0,
                  bottom: TabBar(
                    isScrollable: true,
                    physics: const BouncingScrollPhysics(),
                    indicator: const BoxDecoration(),
                    unselectedLabelColor: darkColor,
                    labelColor: mainColor,
                    tabs: [
                      Tab(
                        child: Container(
                          height: 55,
                          width: 100,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(radius),
                            border: Border.all(width: 1, color: greyLightColor),
                          ),
                          child: Center(
                            child: Text(
                              LocaleKeys.txtAll.tr(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 55,
                          width: 100,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(radius),
                            border: Border.all(width: 1, color: greyLightColor),
                          ),
                          child: Center(
                            child: Text(
                              LocaleKeys.txtUpcoming.tr(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 55,
                          width: 100,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(radius),
                            border: Border.all(width: 1, color: greyLightColor),
                          ),
                          child: Center(
                            child: Text(
                              LocaleKeys.txtSampling.tr(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 55,
                          width: 100,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(radius),
                            border: Border.all(width: 1, color: greyLightColor),
                          ),
                          child: Center(
                            child: Text(
                              LocaleKeys.txtCanceled.tr(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 55,
                          width: 100,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(radius),
                            border: Border.all(width: 1, color: greyLightColor),
                          ),
                          child: Center(
                            child: Text(
                              LocaleKeys.completeTxtMain.tr(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // create widgets for each tab bar here
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      // first tab bar view widget
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 10.0),
                            child: Row(
                              children: [
                                const Text('Tests List',style: titleSmallStyle,),
                                const Spacer(),
                                GeneralUnfilledButton(
                                  width: 100,
                                  height: 40.0,
                                  title: 'Filter date',
                                  onPress: () {
                                    showCustomBottomSheet(
                                      context,
                                      bottomSheetContent: Container(
                                        height:
                                            MediaQuery.of(context).size.height * 0.5,
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(radius),
                                            topRight: Radius.circular(radius),
                                          ),
                                        ),
                                        padding: const EdgeInsetsDirectional.only(
                                            start: 20.0, end: 20.0),
                                        child: SyncfusionFlutterDatePicker(),
                                      ),
                                      bottomSheetHeight: 0.5,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          verticalMiniSpace,
                          ConditionalBuilder(
                            condition: true,
                            builder: (context) => Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: TechHomeReservationsCart(
                                    index: index,
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    verticalMiniSpace,
                                itemCount: 6,
                              ),
                            ),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                      // second tab bar view widget
                      Column(
                        children: [
                          ConditionalBuilder(
                            condition: true,
                            builder: (context) => Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: TechHomeReservationsCart(
                                    index: index,
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    verticalMiniSpace,
                                itemCount: 4,
                              ),
                            ),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                      // third tab bar view widget
                      Column(
                        children: [
                          ConditionalBuilder(
                            condition: true,
                            builder: (context) => Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: TechHomeReservationsCart(
                                    index: index,
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    verticalMiniSpace,
                                itemCount: 4,
                              ),
                            ),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                      // fourth tab bar view widget
                      Column(
                        children: [
                          ConditionalBuilder(
                            condition: true,
                            builder: (context) => Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: TechHomeReservationsCart(
                                    index: index,
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    verticalMiniSpace,
                                itemCount: 4,
                              ),
                            ),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                      // fifth tab bar view widget
                      Column(
                        children: [
                          ConditionalBuilder(
                            condition: true,
                            builder: (context) => Expanded(
                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: TechHomeReservationsCart(
                                    index: index,
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    verticalMiniSpace,
                                itemCount: 4,
                              ),
                            ),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
