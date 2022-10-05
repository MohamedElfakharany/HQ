import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/intro_screens/auth/login_screen.dart';
import 'package:hq/screens/intro_screens/auth/register/select_country_screen.dart';
import 'package:hq/screens/intro_screens/auth/register/sign_up_screen.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key, this.isSignOut}) : super(key: key);
  bool? isSignOut = false;
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // IconData FATBtnNext = ;
  bool isLast = false;
  var boardController = PageController();
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboarding1.svg',
      body: LocaleKeys.onboardingBody.tr(),
      title: LocaleKeys.onboardingTitle.tr(),
    ),
    BoardingModel(
      image: 'assets/images/onboarding1.svg',
      body: LocaleKeys.onboardingBody.tr(),
      title: LocaleKeys.onboardingTitle.tr(),
    ),
    BoardingModel(
      image: 'assets/images/onboarding1.svg',
      body: LocaleKeys.onboardingBody.tr(),
      title: LocaleKeys.onboardingTitle.tr(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: whiteColor,
          // appBar: AppBar(
          //   leading: Padding(
          //     padding: const EdgeInsetsDirectional.only(start: 20),
          //     child: IconButton(
          //       onPressed: () {
          //           Navigator.pop(context);
          //       },
          //       alignment: AlignmentDirectional.topStart,
          //       icon: const Icon(
          //         Icons.arrow_back,
          //         color: greyDarkColor,
          //       ),
          //     ),
          //   ),
          //   backgroundColor: whiteColor,
          //   elevation: 0.0,
          // ),
          body: Padding(
            padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (int index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        isLast = false;
                      }
                    },
                    physics: const BouncingScrollPhysics(),
                    controller: boardController,
                    itemBuilder: (context, index) =>
                        buildBoardingItem(boarding[index]),
                    itemCount: boarding.length,
                  ),
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5,
                      activeDotColor: blueColor,
                    ), // your preferred effect
                  ),
                ),
                // verticalMicroSpace,
                SizedBox(
                  height: 80.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Expanded(
                        //   child: GeneralUnfilledButton(
                        //     width: double.infinity,
                        //     title: 'Sign in',
                        //     onPress: () {
                        //       Navigator.push(
                        //         context,
                        //         FadeRoute(
                        //           page: const LoginScreen(),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        Expanded(
                          child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  FadeRoute(
                                    page: const LoginScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: blueColor,
                                  borderRadius: BorderRadius.circular(radius),
                                ),
                                height: 50.0,
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    LocaleKeys.BtnSignIn.tr(),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: titleSmallStyle.copyWith(
                                        color: blueColor, fontSize: 14),
                                  ),
                                ),
                              )),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(blueColor),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                FadeRoute(
                                  page: const SignUpScreen(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: blueColor,
                                borderRadius: BorderRadius.circular(radius),
                              ),
                              height: 50.0,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  LocaleKeys.BtnRegister.tr(),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: titleSmallStyle.copyWith(
                                    color: whiteColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    AppCubit.get(context).isVisitor = true;
                    Navigator.push(context, FadeRoute(page: const SelectCountryScreen(),),);
                  },
                  child: Text(
                    LocaleKeys.BtnContinueAsGuest.tr(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildBoardingItem(BoardingModel model) => ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            model.image,
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
          ),
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
          verticalMiniSpace,
          Text(
            model.body,
            textAlign: TextAlign.center,
            style: subTitleSmallStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          verticalMediumSpace,
        ],
      );
}