import 'package:ecommerce/core/utils/app_router.dart';
import 'package:ecommerce/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      pageBackgroundColor: color3,
      headerBackgroundColor: color3,
      controllerColor: color9,
      finishButtonText: 'Login',
      onFinish: () {
        GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
      },
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: color9,
      ),
      skipTextButton: const Text(
        'Skip',
        style: TextStyle(
          color: color9,
        ),
      ),
      centerBackground: true,
      indicatorAbove: true,
      trailing: const Text(
        'Login',
        style: TextStyle(
          color: color9,
        ),
      ),
      background: [
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 50),
          child: SvgPicture.asset(
            'assets/svg/shopping_app.svg',
            height: 310.h,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50, top: 50),
          child: SvgPicture.asset(
            'assets/svg/the_search.svg',
            height: 350.h,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, top: 50),
          child: SvgPicture.asset(
            'assets/svg/stripe_payments.svg',
            height: 350.h,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 50),
          child: SvgPicture.asset(
            'assets/svg/delivery_address.svg',
            height: 350.h,
          ),
        ),
      ],
      totalPage: 4,
      speed: 1.8,
      pageBodies: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 420.h,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Welcome to ',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 23.sp,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'MaroStore 💙',
                      style: TextStyle(
                        fontFamily: 'DancingScript',
                        fontSize: 30.sp,
                        color: color9,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 420.h,
              ),
              Text(
                'Search Products \t\t\t\t\t\t\t\t you want!',
                style: TextStyle(
                  fontSize: 23.sp,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 420.h,
              ),
              Text(
                'Pay Online from\t\t\t\t\t home!💸',
                style: TextStyle(
                  fontSize: 23.sp,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 420.h,
              ),
              Text(
                'Delivery to your location!',
                style: TextStyle(
                  fontSize: 23.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
