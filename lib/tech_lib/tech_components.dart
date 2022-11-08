import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/screens/main_screens/notification_screen.dart';
import 'package:hq/shared/components/cached_network_image.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/tech_lib/tech_cubit/tech_cubit.dart';
import 'package:hq/tech_lib/tech_cubit/tech_states.dart';
import 'package:hq/tech_lib/tech_screens/reserved_screens/reservation_details_screen.dart';
import 'package:hq/tech_lib/tech_screens/tech_map_screen.dart';
import 'package:hq/translations/locale_keys.g.dart';

class TechGeneralHomeLayoutAppBar extends StatelessWidget
    with PreferredSizeWidget {
  const TechGeneralHomeLayoutAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppTechCubit, AppTechStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppTechCubit.get(context);
        return Column(
          children: [
            AppBar(
              backgroundColor: greyExtraLightColor,
              elevation: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: whiteColor,
                    radius: 15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: CachedNetworkImage(
                        imageUrl: AppTechCubit.get(context)
                                .userResourceModel
                                ?.data
                                ?.profile ??
                            '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const SizedBox(
                          width: 30,
                          height: 30,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: mainColor,
                          )),
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: whiteColor),
                          child: const Icon(
                            Icons.perm_identity,
                            size: 100,
                            color: mainColor,
                          ),
                        ),
                        width: 120,
                        height: 120,
                      ),
                    ),
                  ),
                  horizontalMiniSpace,
                  Expanded(
                    child: Text(
                      '${cubit.userResourceModel?.data?.name ?? ''} ,',
                      textAlign: TextAlign.start,
                      style: titleSmallStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      FadeRoute(
                        page: const NotificationScreen(),
                      ),
                    );
                  },
                  icon: const ImageIcon(
                    AssetImage('assets/images/notification.png'),
                    color: mainColor,
                  ),
                ),
                horizontalMicroSpace
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
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
                  const Expanded(
                    child:
                    Text('Riyadh , King St 7034'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(85);
}

class TechHomeRequestsCart extends StatelessWidget {
  const TechHomeRequestsCart({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppTechCubit, AppTechStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: 260.0,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              width: 1,
              color: greyLightColor,
            ),
          ),
          alignment: AlignmentDirectional.center,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('#150-450-600'),
                  const Spacer(),
                  Text(
                    '600 ${LocaleKeys.salary.tr()}',
                    style: titleSmallStyle,
                  ),
                ],
              ),
              const Text(
                'Liver Test',
                style: titleSmallStyle,
              ),
              const Text('24 Feb 2022 - 5:30 PM'),
              myHorizontalDivider(),
              Row(
                children: [
                  CachedNetworkImageCircular(
                    imageUrl: imageTest,
                    height: 65,
                  ),
                  horizontalMiniSpace,
                  Text(
                    'Name ${index + 1}',
                    textAlign: TextAlign.center,
                    style: titleSmallStyle2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              verticalMicroSpace,
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      color: greyDarkColor,
                    ),
                    horizontalMiniSpace,
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Riyadh , King St 7034',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, FadeRoute(page: const TechMapScreen(),),);
                            },
                            child: Text(
                              'Show Map',
                              style: titleSmallStyle2.copyWith(decoration: TextDecoration.underline,color: mainColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    horizontalMiniSpace,
                  ],
                ),
              ),
              myHorizontalDivider(),
              GeneralButton(
                height: 40.0,
                title: 'Accept',
                onPress: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}

class TechHomeReservationsCart extends StatelessWidget {
  const TechHomeReservationsCart({Key? key, required this.index, required this.stateColor}) : super(key: key);
  final int index;
  final Color stateColor;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppTechCubit, AppTechStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: (){
            Navigator.push(context, FadeRoute(page: TechReservationsDetailsScreen(stateColor: stateColor,)));
          },
          child: Container(
            height: 250.0,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                width: 1,
                color: greyLightColor,
              ),
            ),
            alignment: AlignmentDirectional.center,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('#150-450-600'),
                    const Spacer(),
                    Text(
                      '600 ${LocaleKeys.salary.tr()}',
                      style: titleSmallStyle,
                    ),
                  ],
                ),
                const Text(
                  'Liver Test',
                  style: titleSmallStyle,
                ),
                const Text('24 Feb 2022 - 5:30 PM'),
                verticalMicroSpace,
                Container(
                  height: 36,
                  width: 130,
                  decoration: BoxDecoration(
                    color: stateColor
                        .withOpacity(0.2),
                    borderRadius:
                    BorderRadius.circular(
                        radius),
                  ),
                  padding:
                  const EdgeInsets.symmetric(
                      horizontal: 8.0),
                  child: Center(
                      child: Text(
                        'Upcoming',
                        style: titleStyle.copyWith(
                            fontSize: 15.0,
                            color: stateColor,
                            fontWeight:
                            FontWeight.normal),
                      )),
                ),
                myHorizontalDivider(),
                Row(
                  children: [
                    CachedNetworkImageCircular(
                      imageUrl: imageTest,
                      height: 55,
                    ),
                    horizontalMiniSpace,
                    Text(
                      'Name ${index + 1}',
                      textAlign: TextAlign.center,
                      style: titleSmallStyle2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: greyDarkColor,
                      ),
                      horizontalMiniSpace,
                      Expanded(
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Riyadh , King St 7034',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, FadeRoute(page: const TechMapScreen(),),);
                              },
                              child: Text(
                                'Show Map',
                                style: titleSmallStyle2.copyWith(decoration: TextDecoration.underline,color: mainColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      horizontalMiniSpace,
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
