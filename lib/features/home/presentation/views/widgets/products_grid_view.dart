import 'package:ecommerce/features/home/presentation/views/widgets/product_item.dart';
import 'package:flutter/material.dart';

import '../../managers/products_cubit/products_cubit.dart';

GridView productsGridView(ProductsCubit productsCubit) {
  return GridView.builder(
    itemCount: productsCubit.productsModelList.length,
    physics: const BouncingScrollPhysics(),
    gridDelegate:
    const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 15,
      childAspectRatio: 0.7,
    ),
    itemBuilder: (context, index) {
      return productItem(
          productModel:
          productsCubit.productsModelList[index]);
    },
  );
}