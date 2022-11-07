import 'package:flutter/material.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/tech_lib/tech_components.dart';

class TechRequestsScreen extends StatelessWidget {
  const TechRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyExtraLightColor,
      appBar: const TechGeneralHomeLayoutAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => InkWell(
            onTap: () {},
            child: TechHomeRequestsCart(index: index),
          ),
          separatorBuilder: (context, index) =>
          verticalMiniSpace,
          itemCount: 10,
        ),
      ),
    );
  }
}
