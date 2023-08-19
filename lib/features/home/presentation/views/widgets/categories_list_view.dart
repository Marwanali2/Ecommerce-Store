import 'package:flutter/material.dart';

import '../../managers/categories_cubit/categories_cubit.dart';

SizedBox categoriesListView(BuildContext context, CategoriesCubit categoriesCubit) {
  return SizedBox(
    height: 110,
    width: MediaQuery.sizeOf(context).width,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: categoriesCubit.categoriesList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              '${categoriesCubit.categoriesList[index].image}',
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    ),
  );
}