// ignore_for_file: must_be_immutable
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/translations/locale_keys.g.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var formKey = GlobalKey<FormState>();
  final focusNodes = Iterable<int>.generate(4).map((_) => FocusNode()).toList();

  final addressController = TextEditingController();
  final markOfPlaceController = TextEditingController();
  final floorController = TextEditingController();
  final buildingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppCreateAddressSuccessState) {
          if (state.successModel.status) {
            Navigator.pop(context);
            showToast(
                msg: state.successModel.message, state: ToastState.success);
          }
        }
      },
      builder: (context, state) {
        AppCubit.get(context).getAddressBasedOnLocation();
        return Scaffold(
          appBar: AppBar(
            // flexibleSpace: Container(
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('assets/images/homeAppbarImage.png'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   width: double.infinity,
            // ),
            title: const Icon(
              Icons.gps_fixed_outlined,
              color: mainColor,
            ),
            elevation: 0.0,
            backgroundColor: whiteColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: greyDarkColor,
              ),
              onPressed: () {
                AppCubit.get(context).currentLocation.serviceEnabled().ignore();
                Navigator.pop(context);
              },
            ),
          ),
          // appBar: GeneralAppBar(title: '',),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMap(
                  zoomControlsEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(AppCubit.get(context).mLatitude,
                        AppCubit.get(context).mLongitude),
                    zoom: 10.0,
                  ),
                  onMapCreated: (controller) {
                    AppCubit.get(context).controller = controller;
                  },
                  onCameraMove: (camera) {},
                  onTap: (latLong) {
                    setState(() {
                      AppCubit.get(context).getAddressBasedOnLocation(
                          lat: latLong.latitude, long: latLong.longitude);
                    });
                  },
                  markers: AppCubit.get(context).markers,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: KeyboardActions(
                      tapOutsideBehavior: TapOutsideBehavior.translucentDismiss,
                      config: KeyboardActionsConfig(
                        // Define ``defaultDoneWidget`` only once in the config
                        defaultDoneWidget: doneKeyboard(),
                        actions: focusNodes
                            .map((focusNode) =>
                                KeyboardActionsItem(focusNode: focusNode))
                            .toList(),
                      ),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Form(
                            key: formKey,
                            child: DefaultFormField(
                              controller: addressController,
                              focusNode: focusNodes[0],
                              suffixIcon: Icons.location_searching,
                              type: TextInputType.text,
                              label: LocaleKeys.txtFieldAddress.tr(),
                              onTap: () {},
                              suffixPressed: () {
                                addressController.text =
                                    AppCubit.get(context).addressLocation ?? '';
                              },
                            ),
                          ),
                          verticalSmallSpace,
                          DefaultFormField(
                            controller: markOfPlaceController,
                            focusNode: focusNodes[1],
                            type: TextInputType.text,
                            label: LocaleKeys.txtMarkOfThePlace.tr(),
                            onTap: () {},
                          ),
                          verticalSmallSpace,
                          DefaultFormField(
                            controller: floorController,
                            focusNode: focusNodes[2],
                            type: TextInputType.number,
                            label: LocaleKeys.txtFloorNumber.tr(),
                            onTap: () {},
                          ),
                          verticalSmallSpace,
                          DefaultFormField(
                            controller: buildingController,
                            focusNode: focusNodes[3],
                            type: TextInputType.number,
                            label: LocaleKeys.txtBuildingNumber.tr(),
                            onTap: () {},
                          ),
                          verticalSmallSpace,
                          ConditionalBuilder(
                            condition: state is! AppCreateAddressLoadingState,
                            builder: (context) => GeneralButton(
                              title: LocaleKeys.txtFieldAddress.tr(),
                              onPress: () {
                                if (formKey.currentState!.validate()) {
                                AppCubit.get(context).createAddress(
                                  latitude: AppCubit.get(context).mLongitude,
                                  longitude: AppCubit.get(context).mLongitude,
                                  address: addressController.text,
                                );
                                }
                              },
                            ),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          ),
                          verticalLargeSpace
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
