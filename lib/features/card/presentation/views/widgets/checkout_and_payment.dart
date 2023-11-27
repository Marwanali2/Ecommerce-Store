import 'package:dotted_line/dotted_line.dart';
import 'package:ecommerce/core/utils/colors.dart';
import 'package:ecommerce/features/card/presentation/managers/carts_cubit.dart';
import 'package:ecommerce/features/stripe_payment/payment_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckOutAndPayment extends StatelessWidget {
  const CheckOutAndPayment({super.key});

  @override
  Widget build(BuildContext context) {
    double? distanceInMeters;
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.26,
      decoration: const BoxDecoration(
        color: color2,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const DottedLine(
              dashColor: Colors.black45,
              dashLength: 10,
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Text(
                  'Subtotal',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: color5,
                  ),
                ),
                const Spacer(),
                BlocBuilder<CartsCubit, CartsState>(
                  builder: (context, state) {
                    CartsCubit cartsCubit =
                        BlocProvider.of<CartsCubit>(context);
                    return Text(
                      '\$  ${cartsCubit.subTotal ?? 0}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            distanceInMeters == null
                ? Row(
                    children: [
                      Text(
                        'Delivery Cost',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: color5,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'select your location first',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Text(
                        'Delivery cost for ${(distanceInMeters! / 1000).toStringAsFixed(2)} KM',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: color5,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$ 30',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
            SizedBox(
              height: 5.h,
            ),
            const Divider(),
            Row(
              children: [
                Text(
                  'Total Cost',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: color4,
                  ),
                ),
                const Spacer(),
                BlocBuilder<CartsCubit, CartsState>(
                  builder: (context, state) {
                    return Text(
                      distanceInMeters == null
                          ? '\$  ${CartsCubit.total}'
                          : '\$  ${CartsCubit.total + 30 ?? 30}',
                      style: TextStyle(
                        color: color1,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  PaymentManager.makePayment(CartsCubit.total + 30, 'USD');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    color9,
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.43,
                      vertical: 10.h,
                    ),
                  ),
                ),
                child: Text(
                  'Pay',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
