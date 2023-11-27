import 'dart:async';
import 'package:ecommerce/features/card/presentation/views/widgets/checkout_and_payment.dart';
import 'package:ecommerce/features/card/presentation/views/widgets/contact_information_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/widgets/show_snack_bar.dart';
import 'checkout_view_appbar.dart';

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
            const ContactInformationContainer(),
            const Spacer(),
            const CheckOutAndPayment(),
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

  @override
  void dispose() {
    if (positionStream != null) {
      positionStream!.cancel();
    }
    super.dispose();
  }
}
