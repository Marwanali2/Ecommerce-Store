import 'dart:async';
import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:ecommerce/features/profile/data/user_model/user_model.dart';
import 'package:ecommerce/features/profile/presentation/managers/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../core/utils/colors.dart';
import '../../../../../core/widgets/show_snack_bar.dart';
import '../../../../auth/presentation/views/register_view.dart';
import '../../../../stripe_payment/payment_manager.dart';
import '../../managers/carts_cubit.dart';
import 'contact_edit_row.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  // static  bool isActive=false;
  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {


  @override
  Widget build(BuildContext context) {
    //PaymentManager paymentManager=PaymentManager(initialState);
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
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  // physics: NeverScrollableScrollPhysics(),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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

                    const SizedBox(
                      height: 15,
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
                              userEmail =
                                  ContactEditRow.theInputUserText.isEmpty
                                      ? userDataCubit.userModel?.email
                                      : ContactEditRow.theInputUserText;
                              isActiveEdit = true;
                            });
                          },
                        );
                      },
                    ),

                    const SizedBox(
                      height: 15,
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
                              userPhone =
                                  ContactEditRow.theInputUserText.isEmpty
                                      ? userDataCubit.userModel?.phone
                                      : ContactEditRow.theInputUserText;
                              isActiveEdit = true;
                            });
                          },
                        );
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
                          width: MediaQuery.sizeOf(context).width * 0.7,
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
                    distanceInMeters==null?
                    Row(
                      children: [
                        Text(
                          'Delivery Cost',
                          style: TextStyle(
                            fontSize: 18,
                            color: color5,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'select your location first',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                        :  Row(
                      children: [
                        Text(
                         'Delivery cost for ${(distanceInMeters!/1000).toStringAsFixed(2)} KM',
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
                              distanceInMeters==null? '\$  ${CartsCubit.total}'  :'\$  ${CartsCubit.total + 30 ?? 30}',
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
                        onPressed: () {
                          PaymentManager.makePayment(
                              CartsCubit.total + 30, 'USD');
                        },
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
                                  MediaQuery.sizeOf(context).width * 0.43,
                              vertical: 10,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Pay',
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

  late double lat;

  late double long;

  late String locationMessage = '';

   StreamSubscription<Position>?positionStream;

  double?distanceInMeters;

  // get current location
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled==false) {
      showSnackBar(context: context, label: 'Please, Enable GBS in your phone', backgroundColor: Colors.red);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar(context: context, label: ' Allow Location permissions in App settings ', backgroundColor: Colors.red);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showSnackBar(context: context, label: ' Location permissions are permanently denied, we cannot request permissions. ', backgroundColor: Colors.red);
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
     positionStream=Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude;
      long = position.longitude;
    });
     distanceInMeters = Geolocator.distanceBetween(lat , long , 30.033333, 31.233334);
    setState(() {
      locationMessage = 'latitude: $lat , longitude: $long';
    });
  }
  @override
  void dispose() {
    if(positionStream!=null){
      positionStream!.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }
}
