import 'package:dotted_line/dotted_line.dart';
import 'package:ecommerce/features/profile/data/user_model/user_model.dart';
import 'package:ecommerce/features/profile/presentation/managers/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../auth/presentation/views/register_view.dart';
import '../../managers/carts_cubit.dart';
import 'contact_edit_row.dart';

class CheckoutView extends StatefulWidget {
  CheckoutView({Key? key}) : super(key: key);
  // static  bool isActive=false;
  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: color3,
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: color2,
                      maxRadius: 25,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 25,
                        ),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'My Cart',
                      style: TextStyle(
                        color: color4,
                        //fontFamily: 'DancingScript',
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.6,
              width: MediaQuery.sizeOf(context).width * 0.95,
              decoration: BoxDecoration(
                color: color2,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  // physics: NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Contact Information',
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BlocBuilder<UserDataCubit, UserDataState>(
                      builder: (context, state) {
                        UserDataCubit userDataCubit =
                            BlocProvider.of<UserDataCubit>(context);

                        return ContactEditRow(
                          icon: Icons.person_outline,
                          mainText: userDataCubit.userModel?.name ?? '',
                          textType: 'Name',
                          activeEdit: true,
                          onEditIconPressed: () {
                            userDataCubit.editUser(
                              name: userDataCubit.userModel?.name,
                              email: userDataCubit.userModel?.email,
                              password: RegisterView.thePassword,
                              phone: userDataCubit.userModel?.phone,
                            );
                            setState(() {

                            });
                          },

                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BlocConsumer<UserDataCubit, UserDataState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        UserDataCubit userDataCubit =
                            BlocProvider.of<UserDataCubit>(context);
                        return ContactEditRow(
                            icon: Icons.email_outlined,
                            mainText: userDataCubit.userModel?.email ?? '',
                            textType: 'Email',
                            onEditIconPressed: () {});
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BlocBuilder<UserDataCubit, UserDataState>(
                      builder: (context, state) {
                        UserDataCubit userDataCubit =
                            BlocProvider.of<UserDataCubit>(context);
                        return ContactEditRow(
                            icon: Icons.phone_outlined,
                            mainText: userDataCubit.userModel?.phone ?? '',
                            textType: 'Phone',
                            onEditIconPressed: () {});
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      'Address',
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: () async {
                        _getCurrentLocation().then((value) {
                          lat = '${value.latitude}';
                          long = '${value.longitude}';
                          setState(() {
                            locationMessage =
                                'latitude: $lat , longitude: $long';
                          });
                          _liveLocation();
                        });
                        String mapUrl = "geo:$lat,$long";
                        if (await canLaunch(mapUrl)) {
                          await launch(mapUrl);
                        } else {
                          throw "Couldn't launch Map";
                        }
                      },
                      child: SvgPicture.asset(
                        'assets/svg/Map.svg',
                        width: MediaQuery.sizeOf(context).width * 0.7,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      'Payment Method',
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.25,
              decoration: const BoxDecoration(
                color: color2,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const DottedLine(
                      dashColor: Colors.black45,
                      dashLength: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Subtotal',
                          style: TextStyle(
                            fontSize: 18,
                            color: color5,
                          ),
                        ),
                        const Spacer(),
                        BlocBuilder<CartsCubit, CartsState>(
                          builder: (context, state) {
                            CartsCubit cartsCubit =
                                BlocProvider.of<CartsCubit>(context);
                            return Text(
                              '\$  ${cartsCubit.subTotal ?? 0}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Delivery',
                          style: TextStyle(
                            fontSize: 18,
                            color: color5,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '\$ 30',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text(
                          'Total Cost',
                          style: TextStyle(
                            fontSize: 18,
                            color: color4,
                          ),
                        ),
                        const Spacer(),
                        BlocBuilder<CartsCubit, CartsState>(
                          builder: (context, state) {
                            CartsCubit cartsCubit =
                                BlocProvider.of<CartsCubit>(context);
                            return Text(
                              '\$  ${CartsCubit.total + 30 ?? 30}',
                              style: const TextStyle(
                                color: color1,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              color9,
                            ),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.sizeOf(context).width * 0.35,
                                    vertical: 10))),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  late String lat;

  late String long;

  late String locationMessage = '';

  // get current location
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
    });
    setState(() {
      locationMessage = 'latitude: $lat , longitude: $long';
    });
  }
}
