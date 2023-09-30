import 'package:ecommerce/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_router.dart';
import '../utils/colors.dart';

SizedBox enjoyBar(BuildContext context, {required String text}) {
  return SizedBox(
    height: 70.h,
    width: MediaQuery.sizeOf(context).width,
    child:  Row(
   //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Spacer(),
        Center(
          child: Text(
            text,
            style:  TextStyle(
              color: Colors.black,
              fontFamily: 'DancingScript',
              fontSize: 35.sp,
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