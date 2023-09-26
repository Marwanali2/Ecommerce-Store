import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/utils/colors.dart';
import '../../managers/banner_cubit/banner_cubit.dart';
class BannerSection extends StatelessWidget {
  const BannerSection({
    super.key,
    required this.pageController,
    required this.bannersCubit,
  });

  final PageController pageController;
  final BannerCubit bannersCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180.h,
          child: PageView.builder(
            controller: pageController,
            itemCount: bannersCubit.bannersList.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: SizedBox(
                  height: 200.h,
                  width: 350.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0.r),
                    child: Image.network(
                      '${bannersCubit.bannersList[index].imageUrl}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
         SizedBox(
          height: 5.h,
        ),
        Center(
          child: SmoothPageIndicator(
            controller: pageController,
            count: bannersCubit.bannersList.length,
            axisDirection: Axis.horizontal,
            effect:   ScrollingDotsEffect(
              activeDotColor: color9,
              radius: 5.r,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}