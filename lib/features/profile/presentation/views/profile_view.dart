import 'dart:async';
import 'dart:io';
import 'package:ecommerce/core/utils/app_router.dart';
import 'package:ecommerce/features/auth/presentation/views/login_view.dart';
import 'package:ecommerce/features/auth/presentation/views/widgets/text_form_field.dart';
import 'package:ecommerce/features/profile/presentation/views/widgets/profile_appbar_section.dart';
import 'package:ecommerce/features/profile/presentation/views/widgets/profile_edit_row.dart';
import 'package:ecommerce/features/profile/presentation/views/widgets/profile_type_display_container.dart';
import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/show_snack_bar.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/presentation/views/register_view.dart';
import '../../../shared/network/local_network.dart';
import '../managers/user_data_cubit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _selectedImage;

  bool obscureText = true;
  GlobalKey<FormState> formKey = GlobalKey();
  static bool isNameEditActive = false;
  static bool isPhoneEditActive = false;
  static bool isEmailEditActive = false;
  TextEditingController editProfileNameController = TextEditingController();
  TextEditingController editProfilePhoneController = TextEditingController();
  TextEditingController editProfileEmailController = TextEditingController();
  TextEditingController editProfilePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserDataCubit userDataCubit = BlocProvider.of<UserDataCubit>(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: color2,
        body: BlocConsumer<UserDataCubit, UserDataState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SimpleAppBarSection(pageName: S.of(context).Profile),
                    SizedBox(
                      height: 20.h,
                    ),
                    buildProfilePhoto(context),
                    SizedBox(
                      height: 10.h,
                    ),
                    ProfileEditRow(
                        type: S.of(context).profileEditName,
                        onPressed: () {
                          setState(() {
                            isNameEditActive = true;
                          });
                        }),
                    SizedBox(
                      height: 12.h,
                    ),
                    isNameEditActive == true
                        ? buildTextFormField(
                            label: S.of(context).profileEditName,
                            prefixIcon: Icons.person,
                            controller: editProfileNameController,
                            keyboardType: TextInputType.name,
                          )
                        : ProfileTypesDisplayContainer(
                            typeValue: userDataCubit.userModel?.name ?? ''),
                    SizedBox(
                      height: 12.h,
                    ),
                    ProfileEditRow(
                        type: S.of(context).profileEditPhone,
                        onPressed: () {
                          setState(() {
                            isPhoneEditActive = true;
                          });
                        }),
                    SizedBox(
                      height: 12.h,
                    ),
                    isPhoneEditActive == true
                        ? buildTextFormField(
                            label: S.of(context).profileEditPhone,
                            prefixIcon: Icons.numbers,
                            controller: editProfilePhoneController,
                            keyboardType: TextInputType.phone,
                          )
                        : ProfileTypesDisplayContainer(
                            typeValue: userDataCubit.userModel?.phone ?? ''),
                    SizedBox(
                      height: 12.h,
                    ),
                    ProfileEditRow(
                        type: S.of(context).profileEditEmail,
                        onPressed: () {
                          setState(() {
                            isEmailEditActive = true;
                          });
                        }),
                    SizedBox(
                      height: 12.h,
                    ),
                    isEmailEditActive == true
                        ? buildTextFormField(
                            label: S.of(context).profileEditEmail,
                            prefixIcon: Icons.alternate_email,
                            controller: editProfileEmailController,
                            keyboardType: TextInputType.emailAddress,
                          )
                        : ProfileTypesDisplayContainer(
                            typeValue: userDataCubit.userModel?.email ?? ''),
                    SizedBox(
                      height: 12.h,
                    ),
                    ProfileEditRow(
                        type: S.of(context).profileEditLocation,
                        onPressed: () async {
                          _getCurrentLocation().then((value) {
                            lat = value.latitude; //'${value.latitude}';
                            long = value.longitude; //'${value.longitude}';
                            setState(() {
                              locationMessage =
                                  'latitude: ${lat.toString()} , longitude: ${long.toString()}';
                            });
                            _liveLocation();
                          });
                          String mapUrl =
                              "geo:${lat.toString()},${long.toString()}";
                          if (await canLaunchUrlString(mapUrl)) {
                            await launchUrlString(mapUrl);
                          } else {
                            throw "Couldn't launch Map";
                          }
                        }),
                    SizedBox(
                      height: 12.h,
                    ),
                    const ProfileTypesDisplayContainer(typeValue: 'Egypt'),
                    SizedBox(
                      height: 20.h,
                    ),
                    (isNameEditActive == true ||
                            isPhoneEditActive == true ||
                            isEmailEditActive == true)
                        ? Center(
                            child: buildElevatedButton(userDataCubit, context,
                                S.of(context).profileSave, () {
                              setState(() {
                                editProfileNameController.text.isEmpty
                                    ? userDataCubit.userModel?.name
                                    : userDataCubit.userModel?.name =
                                        editProfileNameController.text;
                                editProfilePhoneController.text.isEmpty
                                    ? userDataCubit.userModel?.email
                                    : userDataCubit.userModel?.email =
                                        editProfilePhoneController.text;
                                editProfileEmailController.text.isEmpty
                                    ? userDataCubit.userModel?.phone
                                    : userDataCubit.userModel?.phone =
                                        editProfileEmailController.text;
                                userDataCubit.editUser(
                                  name: userDataCubit.userModel?.name,
                                  email: userDataCubit.userModel?.email,
                                  password: RegisterView.thePassword,
                                  phone: userDataCubit.userModel?.phone,
                                );

                                isNameEditActive = false;
                                isPhoneEditActive = false;
                                isEmailEditActive = false;
                              });
                            }),
                          )
                        : Center(
                            child: BlocConsumer<UserDataCubit, UserDataState>(
                              listener: (context, state) {
                                if (state is LogOutFailureState) {
                                  showSnackBar(
                                      context: context,
                                      label: "Failed To Log out, Try Again...",
                                      backgroundColor: Colors.red);
                                } else if (state is LogOutSuccessState) {
                                  showSnackBar(
                                      context: context,
                                      label: " Successful Log out",
                                      backgroundColor: Colors.green);
                                }
                              },
                              builder: (context, state) {
                                return buildElevatedButton(
                                  userDataCubit,
                                  context,
                                  state is LogOutLoadingState
                                      ? "Loading..."
                                      : S.of(context).profileLogout,
                                  () async {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => LoginView(),
                                      ),
                                    );
                                    await userDataCubit.logOut();
                                    CachedNetwork.deleteCacheItem(key: 'token');

                                    //    await userDataCubit.logOut();
                                    /*  setState(() {
                                      userToken ==
                                          UserDataCubit().userModel?.token;
                                    });
                                    CachedNetwork.deleteCacheItem(key: 'token')
                                        .then((value) {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginView()));
                                    });*/
                                    // Navigator.of(context).pushReplacement(
                                    //   MaterialPageRoute(builder: (context) => const LoginView()),
                                    //
                                    // );
                                    // setState(() {
                                    //   userToken='';
                                    // });
                                    //   print('Deleted token is $userToken');
                                    // Navigator.of(context).pushAndRemoveUntil(
                                    //   MaterialPageRoute(builder: (context) => const EcommerceApp()),
                                    //       (Route<dynamic> route) => false,
                                    // );
                                    //     print('******************* $userToken');
                                  },
                                );
                              },
                            ),
                          ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(UserDataCubit userDataCubit,
      BuildContext context, String? label, void Function()? onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          color9,
        ),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.3,
            vertical: 10,
          ),
        ),
      ),
      child: Text(
        label!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  Center buildProfilePhoto(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                    width: 150.w,
                    height: 150.h,
                  )
                : Image.asset(
                    'assets/images/user_avatar.png',
                    width: 150.w,
                    height: 150.h,
                  ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: color9.withOpacity(
                0.8,
              ),
              maxRadius: 25,
              child: IconButton(
                onPressed: () {
                  //   _pickImageFromGalley();
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.25,
                        width: MediaQuery.sizeOf(context).width,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select from:',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 70.w,
                                    height: 70.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        50,
                                      ),
                                      border: Border.all(
                                        color: color9,
                                        width: 2.w,
                                      ),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        _pickImageFromGalley();
                                      },
                                      icon: const Icon(
                                        Icons.image,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70.w,
                                    height: 70.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        50,
                                      ),
                                      border: Border.all(
                                        color: color9,
                                        width: 2.w,
                                      ),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        _pickImageFromCamera();
                                      },
                                      icon: const Icon(
                                        Icons.camera,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Gallery',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  Text(
                                    'Camera',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _pickImageFromGalley() async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
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
    // TODO: implement dispose
    super.dispose();
  }
}
