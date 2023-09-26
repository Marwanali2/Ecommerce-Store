import 'dart:async';
import 'package:dotted_line/dotted_line.dart';
import 'package:ecommerce/features/profile/presentation/managers/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/widgets/show_snack_bar.dart';
import '../../../../auth/presentation/views/register_view.dart';
import '../../../../stripe_payment/payment_manager.dart';
import '../../managers/carts_cubit.dart';
import 'checkout_view_appbar.dart';
import 'contact_edit_row.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

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
            const CheckoutViewAppBar(),
            SizedBox(
              height: 15.h,
            ),
            contactInformationContainerSection(context),
            const Spacer(),
            checkoutCostAndPaymentSection(context),
          ],
        ),
      ),
    );
  }

  Container contactInformationContainerSection(BuildContext context) {
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
          // physics: NeverScrollableScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      // userDataCubit.editUser(
                      //   name: userDataCubit.userModel?.name,
                      //   email: userDataCubit.userModel?.email,
                      //   password: RegisterView.thePassword,
                      //   phone: userDataCubit.userModel?.phone,
                      // );
                      // userName= ContactEditRow.theInputUserText.isEmpty?userDataCubit.userModel?.name:ContactEditRow.theInputUserText;
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
            // const SizedBox(
            //   height: 12,
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

  Container checkoutCostAndPaymentSection(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.26,
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
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Text(
                  'Subtotal',
                  style: TextStyle(
                    fontSize: 16.sp,
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
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            distanceInMeters == null
                ? Row(
                    children: [
                      Text(
                        'Delivery Cost',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: color5,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'select your location first',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Text(
                        'Delivery cost for ${(distanceInMeters! / 1000).toStringAsFixed(2)} KM',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: color5,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '\$ 30',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
            SizedBox(
              height: 5.h,
            ),
            const Divider(),
            Row(
              children: [
                Text(
                  'Total Cost',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: color4,
                  ),
                ),
                const Spacer(),
                BlocBuilder<CartsCubit, CartsState>(
                  builder: (context, state) {
                    CartsCubit cartsCubit =
                        BlocProvider.of<CartsCubit>(context);
                    return Text(
                      distanceInMeters == null
                          ? '\$  ${CartsCubit.total}'
                          : '\$  ${CartsCubit.total + 30 ?? 30}',
                      style: TextStyle(
                        color: color1,
                        fontSize: 16.sp,
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
                onPressed: () {
                  PaymentManager.makePayment(CartsCubit.total + 30, 'USD');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    color9,
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.43,
                      vertical: 10.h,
                    ),
                  ),
                ),
                child: Text(
                  'Pay',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
      if(context.mounted){
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
        if(context.mounted){
          showSnackBar(
              context: context,
              label: ' Allow Location permissions in App settings ',
              backgroundColor: Colors.red);
        }
      }
    }

    if (permission == LocationPermission.deniedForever) {
     if(context.mounted){
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

  @override
  void dispose() {
    if (positionStream != null) {
      positionStream!.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }
}
