import 'package:flutter/material.dart';
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
          height: 200,
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
                  height: 200,
                  width: 350,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
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
        const SizedBox(
          height: 5,
        ),
        Center(
          child: SmoothPageIndicator(
            controller: pageController,
            count: bannersCubit.bannersList.length,
            axisDirection: Axis.horizontal,
            effect:  const ScrollingDotsEffect(
              activeDotColor: color9,
              radius: 5,
            ),
          ),
        ),
      ],
    );
  }
}