import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/tech_lib/tech_components.dart';
import 'package:hq/tech_lib/tech_cubit/tech_cubit.dart';
import 'package:hq/tech_lib/tech_cubit/tech_states.dart';
import 'package:hq/translations/locale_keys.g.dart';

class TechHomeScreen extends StatefulWidget {
  const TechHomeScreen({Key? key}) : super(key: key);

  @override
  State<TechHomeScreen> createState() => _TechHomeScreenState();
}

class _TechHomeScreenState extends State<TechHomeScreen> {

  @override
  void initState(){
    super.initState();
    AppTechCubit.get(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppTechCubit()..getProfile(),
      child: BlocConsumer<AppTechCubit ,AppTechStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppTechCubit.get(context);
          return Scaffold(
            backgroundColor: greyExtraLightColor,
            appBar: const TechGeneralHomeLayoutAppBar(),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => Container(
                color: greyExtraLightColor,
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    verticalSmallSpace,
                    Row(
                      children: [
                        Text(LocaleKeys.txtTestCategories.tr(),
                            style: titleStyle),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              cubit.changeBottomScreen(1);
                            });
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
                      height: 265.0,
                      width: double.infinity,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {},
                          child: TechHomeRequestsCart(index: index),
                        ),
                        separatorBuilder: (context, index) =>
                        horizontalMiniSpace,
                        itemCount: 10,
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
                            setState(() {
                              cubit.changeBottomScreen(1);
                            });
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
                      height: 240.0,
                      width: double.infinity,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {},
                          child: TechHomeReservationsCart(index: index),
                        ),
                        separatorBuilder: (context, index) =>
                        horizontalMiniSpace,
                        itemCount: 10,
                      ),
                    ),
                    verticalMediumSpace,
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
}
