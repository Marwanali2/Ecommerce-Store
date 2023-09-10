import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../core/utils/colors.dart';

class CheckoutView extends StatefulWidget {
   CheckoutView({Key? key}) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    ContactEditRow(
                        icon: Icons.email_outlined,
                        mainText: 'emailemailemailtest@gmail.com',
                        textType: 'Email',
                        onEditIconPressed: () {}),
                    const SizedBox(
                      height: 15,
                    ),
                    ContactEditRow(
                        icon: Icons.phone_outlined,
                        mainText: '01125727329',
                        textType: 'Phone',
                        onEditIconPressed: () {}),
                    const SizedBox(
                      height: 12,
                    ),
                     Text(
                      '$locationMessage -Address',
                      style: const TextStyle(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _getCurrentLocation().then((value) {
                          lat=value.latitude;
                          long=value.longitude;
                          setState(() {
                            locationMessage='latitude: $lat , longitude: $long';
                          });
                          _liveLocation();
                        });
                      },
                      child: const Text(
                        'Get your location',
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _openMap(lat,long);
                      },
                      child: const Text(
                        'Open your location',
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
                    const Row(
                      children: [
                        Text(
                          'Subtotal',
                          style: TextStyle(
                            fontSize: 18,
                            color: color5,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '\$ 200',
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
                    const Row(
                      children: [
                        Text(
                          'Total Cost',
                          style: TextStyle(
                            fontSize: 18,
                            color: color4,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '\$ 200',
                          style: TextStyle(
                              color: color1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                        onPressed: () {

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

  late double lat;

  late double long;

  late String locationMessage='';
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
    Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position){
      lat=position.latitude;
      long=position.longitude;
    });
    setState(() {
      locationMessage='latitude: $lat , longitude: $long';
    });
  }

  // open current location in google map


  Future<void> _openMap(double latitude, double longitude) async {
    String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunchUrlString(googleMapsUrl)) {
      await launchUrlString(googleMapsUrl);
    } else {
      throw 'Could not open the location in Google Maps.';
    }
  }
}

class ContactEditRow extends StatelessWidget {
  const ContactEditRow({
    super.key,
    required this.icon,
    required this.mainText,
    required this.textType,
    this.onEditIconPressed,
  });

  final IconData icon;
  final String mainText;
  final String textType;
  final void Function()? onEditIconPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
            backgroundColor: color12, maxRadius: 25, child: Icon(icon) //icon,
            ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mainText,
              style: const TextStyle(
                fontSize: 15,
                color: color10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              textType,
              style: const TextStyle(
                color: color5,
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: onEditIconPressed,
          child: SizedBox(
            child: SvgPicture.asset(
              'assets/svg/edit_Icon.svg',
              width: 28,
            ),
          ),
        ),
      ],
    );
  }
}
