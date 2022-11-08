import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/tech_lib/tech_cubit/tech_cubit.dart';
import 'package:hq/tech_lib/tech_cubit/tech_states.dart';

class TechMapScreen extends StatefulWidget {
  const TechMapScreen({Key? key}) : super(key: key);

  @override
  State<TechMapScreen> createState() => _TechMapScreenState();
}

class _TechMapScreenState extends State<TechMapScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppTechCubit, AppTechStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
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
                Navigator.pop(context);
              },
            ),
          ),
          // appBar: GeneralAppBar(title: '',),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              zoomControlsEnabled: true,
              myLocationEnabled: true,

              initialCameraPosition: const CameraPosition(
                // target: LatLng(AppCubit.get(context).mLatitude,
                //     AppCubit.get(context).mLongitude),
                target: LatLng(31.168625, 31.225432),
                zoom: 18.0,
              ),
              onCameraMove: (camera) {},
              markers: AppTechCubit.get(context).markers,
            ),
          ),
        );
      },
    );
  }
}