import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/tech_lib/tech_components.dart';
import 'package:hq/tech_lib/tech_cubit/tech_cubit.dart';
import 'package:hq/tech_lib/tech_cubit/tech_states.dart';
import 'package:hq/translations/locale_keys.g.dart';

class TechRequestsScreen extends StatelessWidget {
  const TechRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppTechCubit.get(context);
    return BlocConsumer<AppTechCubit, AppTechStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          backgroundColor: greyExtraLightColor,
          appBar: const TechGeneralHomeLayoutAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ConditionalBuilder(
              condition: cubit.techRequestsModel?.data?.isNotEmpty == true,
              builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {},
                  child: TechHomeRequestsCart(index: index),
                ),
                separatorBuilder: (context, index) =>
                verticalMiniSpace,
                itemCount: AppTechCubit.get(context).techRequestsModel?.data?.length ?? 0,
              ),
              fallback: (context) => Center(
                child: ScreenHolder(msg: LocaleKeys.txtRequests2.tr()),
              ),
            ),
          ),
        );
      },
    );
  }
}
