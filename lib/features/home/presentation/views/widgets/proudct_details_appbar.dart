import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
class ProductDetailsAppBar extends StatelessWidget {
  const ProductDetailsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12,),
      child: Center(
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color3,
              maxRadius: 25,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                ),
                color: Colors.black,
                onPressed: () {

                },
              ),
            ),
            SizedBox(width: MediaQuery.sizeOf(context).width*0.2,),
            const Text(
              'Product Name',
              style: TextStyle(
                color: color4,
                //fontFamily: 'DancingScript',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

          ],
        ),
      ),
    );
  }
}