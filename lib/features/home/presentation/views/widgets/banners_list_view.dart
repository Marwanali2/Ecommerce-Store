import 'package:flutter/material.dart';

import '../../managers/banner_cubit/banner_cubit.dart';

SizedBox bannersListView(PageController pageController, BannerCubit bannersCubit) {
  return SizedBox(
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
  );
}