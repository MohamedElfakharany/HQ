import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/translations/locale_keys.g.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: whiteColor,
          appBar: const GeneralHomeLayoutAppBar(),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomScreen(index);
            },
            showUnselectedLabels: true,
            selectedItemColor: blueColor,
            unselectedItemColor: greyLightColor,
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: LocaleKeys.TxtHomeVisit.tr(),
              ),
              BottomNavigationBarItem(
                icon: const ImageIcon(AssetImage('assets/images/tests.png'),),
                label: LocaleKeys.homeTxtTestLibrary.tr(),
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.offline_bolt_outlined),
              //   label: 'Offers',
              // ),
              BottomNavigationBarItem(
                icon: const ImageIcon(AssetImage('assets/images/reserved.png'),),
                label: LocaleKeys.txtReserved.tr(),
              ),
              BottomNavigationBarItem(
                icon: const ImageIcon(AssetImage('assets/images/result.png'),),
                label: LocaleKeys.BtnResult.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.perm_identity_outlined),
                label: LocaleKeys.drawerSettings.tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}
