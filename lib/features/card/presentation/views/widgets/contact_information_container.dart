import 'dart:async';

import 'package:ecommerce/core/utils/colors.dart';
import 'package:ecommerce/core/widgets/show_snack_bar.dart';
import 'package:ecommerce/features/auth/presentation/views/register_view.dart';
import 'package:ecommerce/features/card/presentation/views/widgets/contact_edit_row.dart';
import 'package:ecommerce/features/profile/presentation/managers/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactInformationContainer extends StatefulWidget {
  const ContactInformationContainer({super.key});

  @override
  State<ContactInformationContainer> createState() =>
      _ContactInformationContainerState();
}

class _ContactInformationContainerState
    extends State<ContactInformationContainer> {
  @override
  Widget build(BuildContext context) {
    late double lat;
    late double long;
    late String locationMessage = '';
    StreamSubscription<Position>? positionStream;
    double? distanceInMeters;

    // get current location
    Future<Position> _getCurrentLocation() async {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled == false) {
        if (context.mounted) {
          showSnackBar(
              context: context,
              label: 'Please, Enable GBS in your phone',
              backgroundColor: Colors.red);
        }
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (context.mounted) {
            showSnackBar(
                context: context,
                label: ' Allow Location permissions in App settings ',
                backgroundColor: Colors.red);
          }
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (context.mounted) {
          showSnackBar(
              context: context,
              label:
                  ' Location permissions are permanently denied, we cannot request permissions. ',
              backgroundColor: Colors.red);
        }
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
      positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position position) {
        lat = position.latitude;
        long = position.longitude;
      });
      distanceInMeters =
          Geolocator.distanceBetween(lat, long, 30.033333, 31.233334);
      setState(() {
        locationMessage = 'latitude: $lat , longitude: $long';
      });
    }

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.56,
      width: MediaQuery.sizeOf(context).width * 0.95,
      decoration: BoxDecoration(
        color: color2,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 2.w,
            ),
            Text(
              'Contact Information',
              style: TextStyle(fontSize: 15.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            // user name
            BlocBuilder<UserDataCubit, UserDataState>(
              builder: (context, state) {
                UserDataCubit userDataCubit =
                    BlocProvider.of<UserDataCubit>(context);
                String? userName = userDataCubit.userModel?.name;
                bool isActiveEdit = false;
                return ContactEditRow(
                  icon: Icons.person_outline,
                  mainText: userName ?? '',
                  textType: 'Name',
                  activeEdit: isActiveEdit,
                  onEditIconPressed: () {
                    setState(() {
                      isActiveEdit = true;
                    });
                  },
                );
              },
            ),

            SizedBox(
              height: 15.h,
            ),

            // user email
            BlocBuilder<UserDataCubit, UserDataState>(
              builder: (context, state) {
                UserDataCubit userDataCubit =
                    BlocProvider.of<UserDataCubit>(context);
                String? userEmail = userDataCubit.userModel?.email;
                bool isActiveEdit = false;
                return ContactEditRow(
                  icon: Icons.email_outlined,
                  mainText: userEmail ?? '',
                  textType: 'Email',
                  activeEdit: isActiveEdit,
                  keyboardType: TextInputType.emailAddress,
                  onEditIconPressed: () {
                    setState(() {
                      userDataCubit.editUser(
                        name: userDataCubit.userModel?.name,
                        email: userDataCubit.userModel?.email,
                        password: RegisterView.thePassword,
                        phone: userDataCubit.userModel?.phone,
                      );
                      userEmail = ContactEditRow.theInputUserText.isEmpty
                          ? userDataCubit.userModel?.email
                          : ContactEditRow.theInputUserText;
                      isActiveEdit = true;
                    });
                  },
                );
              },
            ),

            SizedBox(
              height: 15.h,
            ),

            // user phone
            BlocBuilder<UserDataCubit, UserDataState>(
              builder: (context, state) {
                UserDataCubit userDataCubit =
                    BlocProvider.of<UserDataCubit>(context);
                String? userPhone = userDataCubit.userModel?.phone;
                bool isActiveEdit = false;
                return ContactEditRow(
                  icon: Icons.phone_outlined,
                  mainText: userPhone ?? '',
                  textType: 'Phone',
                  activeEdit: isActiveEdit,
                  keyboardType: TextInputType.phone,
                  onEditIconPressed: () {
                    setState(() {
                      userDataCubit.editUser(
                        name: userDataCubit.userModel?.name,
                        email: userDataCubit.userModel?.email,
                        password: RegisterView.thePassword,
                        phone: userDataCubit.userModel?.phone,
                      );
                      userPhone = ContactEditRow.theInputUserText.isEmpty
                          ? userDataCubit.userModel?.phone
                          : ContactEditRow.theInputUserText;
                      isActiveEdit = true;
                    });
                  },
                );
              },
            ),

            SizedBox(
              height: 10.h,
            ),
            Text(
              'Address',
              style: TextStyle(fontSize: 15.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  _getCurrentLocation().then((value) {
                    lat = value.latitude; //'${value.latitude}';
                    long = value.longitude; //'${value.longitude}';
                    setState(() {
                      locationMessage =
                          'latitude: ${lat.toString()} , longitude: ${long.toString()}';
                    });
                    _liveLocation();
                  });
                  String mapUrl = "geo:${lat.toString()},${long.toString()}";
                  if (await canLaunchUrlString(mapUrl)) {
                    await launchUrlString(mapUrl);
                  } else {
                    throw "Couldn't launch Map";
                  }
                },
                child: SvgPicture.asset(
                  'assets/svg/Map.svg',
                  width: MediaQuery.sizeOf(context).width * 0.8,
                ),
              ),
            ),

            // ),
            // Row(
            //   children: [
            //     const Text(
            //       'Payment Method',
            //       style: TextStyle(fontSize: 17),
            //     ),
            //     const Spacer(),
            //     ElevatedButton(
            //       onPressed: () {
            //         showModalBottomSheet(
            //           context: context,
            //           builder: (BuildContext context) {
            //             return SizedBox(
            //               child: Center(
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                     right: 10,
            //                     left: 10,
            //                     top: 10,
            //                   ),
            //                   child: Column(
            //                     //   mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       CreditCardWidget(
            //                         cardNumber: '4364 1345 8932 8378',
            //                         expiryDate: '05/24',
            //                         cardHolderName: 'maromaromaro',
            //                         cvvCode: '333333',
            //                         showBackView: true,
            //                         onCreditCardWidgetChange:
            //                             (CreditCardBrand) {}, //true when you want to show cvv(back) view
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             );
            //           },
            //         );
            //       },
            //       style: ButtonStyle(
            //         backgroundColor: MaterialStateProperty.all(color1),
            //         shape: MaterialStateProperty.all(
            //           RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //       ),
            //       child: const Text(
            //         'Add New Card',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 15,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
