import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/intro_screens/auth/register/select_branch_screen.dart';
import 'package:hq/screens/intro_screens/widget_components.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ProfileChangeCityScreen extends StatelessWidget {
  const ProfileChangeCityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: GeneralAppBar(title: ''),
          body: Container(
            color: whiteColor,
            child: Padding(
              padding:
              const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
              child: Column(
                children: [
                  verticalSmallSpace,
                  Text(
                    '${LocaleKeys.BtnSelect.tr()} ${LocaleKeys.txtCity.tr()}',
                    style: titleStyle.copyWith(fontSize: 30),
                  ),
                  Text(
                    LocaleKeys.onboardingBody.tr(),
                    style: subTitleSmallStyle,
                  ),
                  verticalLargeSpace,
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {},
                        child: RegionCard(title: AppCubit.get(context).cityModel!.data![index].title,),
                      ),
                      separatorBuilder: (context, index) => verticalSmallSpace,
                      itemCount: AppCubit.get(context).cityModel!.data!.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
