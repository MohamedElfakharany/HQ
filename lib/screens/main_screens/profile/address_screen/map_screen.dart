// ignore_for_file: must_be_immutable
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/translations/locale_keys.g.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class MapScreen extends StatefulWidget {
  MapScreen({Key? key, this.testName}) : super(key: key);
  String? testName;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Location currentLocation = Location();
  final Set<Marker> _markers = {};
  var formKey = GlobalKey<FormState>();

  double mLatitude = 0;
  double mLongitude = 0;
  geo.Placemark? userAddress;

  final addressController = TextEditingController();
  final markOfPlaceController = TextEditingController();
  final floorController = TextEditingController();
  final buildingController = TextEditingController();

  // Future _getLocation() async {
  //   Location location = Location();
  //   LocationData pos = await location.getLocation();
  //   mLatitude = pos.latitude!;
  //   mLongitude = pos.longitude!;
  //   if (kDebugMode) {
  //     print('latitude inside get location $mLatitude');
  //   }
  //   var permission = await currentLocation.hasPermission();
  //   if (permission == PermissionStatus.denied) {
  //     permission = await currentLocation.requestPermission();
  //     if (permission != PermissionStatus.granted) {
  //       return;
  //     }
  //   } else {
  //     currentLocation.onLocationChanged.listen((LocationData loc) {
  //       mLatitude = loc.latitude!;
  //       mLongitude = loc.longitude!;
  //       _controller?.animateCamera(
  //         CameraUpdate.newCameraPosition(
  //           CameraPosition(
  //             target: LatLng(
  //                 loc.latitude ?? mLatitude, loc.longitude ?? mLongitude),
  //             zoom: 17.0,
  //           ),
  //         ),
  //       );
  //       _markers.add(
  //         Marker(
  //             markerId: const MarkerId('Home'),
  //             position: LatLng(
  //                 loc.latitude ?? mLatitude, loc.longitude ?? mLongitude)),
  //       );
  //     });
  //   }
  // }
  //
  // Future<void> getAddressBasedOnLocation() async {
  //   print('latitude, longitude before $mLatitude, $mLongitude}');
  //   if (mLatitude == 0.0 && mLongitude == 0.0) {
  //     await _getLocation().then((value) async {
  //       print('latitude, longitude after $mLatitude, $mLongitude}');
  //       var address = await geo.placemarkFromCoordinates(mLatitude, mLongitude);
  //       userAddress = address.first;
  //       if (kDebugMode) {
  //         print('from getAddressBasedOnLocation userAddress : $userAddress');
  //       }
  //       _controller?.animateCamera(
  //         CameraUpdate.newCameraPosition(
  //           CameraPosition(
  //             target: LatLng(mLatitude, mLongitude),
  //             zoom: 17.0,
  //           ),
  //         ),
  //       );
  //       _markers.add(
  //         Marker(
  //             markerId: const MarkerId('Home'),
  //             position: LatLng(mLatitude, mLongitude)),
  //       );
  //       addressController.text =
  //       '${userAddress?.administrativeArea} ${userAddress?.locality} ${userAddress?.street} ${userAddress?.subThoroughfare}';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // getAddressBasedOnLocation();
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
            title: const Text(
              '',
              style: titleStyle,
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: greyDarkColor,
              ),
              onPressed: () {
                currentLocation.serviceEnabled().ignore();
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
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(30.033333, 31.233334),
                    zoom: 18.0,
                  ),
                  onMapCreated: (controller) {
                    _controller = controller;
                  },
                  markers: _markers,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .5,
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          DefaultFormField(
                            suffixIcon: Icons.location_searching,
                            controller: addressController,
                            type: TextInputType.text,
                            validate: (value){
                              if (value!.isEmpty){
                                return '';
                              }
                            },
                            label: LocaleKeys.txtFieldAddress.tr(),
                            onTap: () {},
                          ),
                          verticalSmallSpace,
                          DefaultFormField(
                            controller: markOfPlaceController,
                            type: TextInputType.text,
                            validate: (value){
                              if (value!.isEmpty){
                                return '';
                              }
                            },
                            label: LocaleKeys.txtMarkOfThePlace.tr(),
                            onTap: () {},
                          ),
                          verticalSmallSpace,
                          DefaultFormField(
                            controller: floorController,
                            type: TextInputType.number,
                            validate: (value){
                              if (value!.isEmpty){
                                return '';
                              }
                            },
                            label: LocaleKeys.txtFloorNumber.tr(),
                            onTap: () {},
                          ),
                          verticalSmallSpace,
                          DefaultFormField(
                            controller: buildingController,
                            type: TextInputType.number,
                            validate: (value){
                              if (value!.isEmpty){
                                return '';
                              }
                            },
                            label: LocaleKeys.txtBuildingNumber.tr(),
                            onTap: () {},
                          ),
                          verticalSmallSpace,
                          GeneralButton(
                            title: LocaleKeys.txtFieldAddress.tr(),
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                dispose();
                                Navigator.pop(context);
                              }
                            },
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