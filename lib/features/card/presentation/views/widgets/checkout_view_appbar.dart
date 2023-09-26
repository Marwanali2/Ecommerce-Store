import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/colors.dart';

class CheckoutViewAppBar extends StatelessWidget {
  const CheckoutViewAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color2,
              maxRadius: 25,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 25,
                ),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const Spacer(),
             Text(
              'My Cart',
              style: TextStyle(
                color: color4,
                //fontFamily: 'DancingScript',
                fontSize: 18.sp,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}