import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
import '../../../data/models/products_model.dart';

Widget productItem({required ProductModel productModel}) {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      border: Border.all(
        color: Colors.indigo,
        width: 2,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                children: [
                  productModel.oldPrice == productModel.price
                      ? Text(
                    '${productModel.price}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                      : Row(
                    children: [
                      Text(
                        '${productModel.oldPrice}\$',
                        style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.red,
                          decorationThickness: 1.5,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${productModel.price}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 1,
                  ),
                  const Text(
                    '\$',
                    style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: mainColor,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  '${productModel.image}',
                ),
                fit: BoxFit.fill,
              ),
              color: Colors.white10,
              border: Border.all(color: Colors.indigo, width: 2),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(
                  20,
                ),
                topLeft: Radius.circular(20),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${productModel.name}',
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          productModel.discount!=0? Center(
            child: Container(
              width: 110,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20,),color: Colors.green,),
              child: Center(
                child: Text(
                  'Discount ${productModel.discount}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'DancingScript',
                  ),
                ),
              ),
            ),
          ):const SizedBox(),
          const Spacer(),
        ],
      ),
    ),
  );
}