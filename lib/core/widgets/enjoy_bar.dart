import 'package:ecommerce/core/utils/functions.dart';
import 'package:ecommerce/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_router.dart';
import '../utils/colors.dart';
import 'package:circular_menu/circular_menu.dart';
SizedBox enjoyBar(BuildContext context, {required String text}) {
  return SizedBox(
    height: 70.h,
    width: MediaQuery.sizeOf(context).width,
    child:  Row(
   //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('EN'),
        Padding(
          padding: const EdgeInsets.only(right: 35,left: 15),
          child: SizedBox(
            width: 20.w,
            child: SwitchListTile(
              activeColor: Colors.green,
              value: true, onChanged: (value) {

            },),
          ),
        ),
        Text('AR'),
        const Spacer(),
        Center(
          child: Text(
            text,
            style:  TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'DancingScript',
              fontSize: isArabic()?30.sp:32.sp,
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRouter.kProfileView);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              width: 40.w,
              child: Image.asset(
                'assets/images/user_avatar.png',
              ),
            ),
          ),
        ),

      ],
    ),
  );
}