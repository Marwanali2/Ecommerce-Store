import 'package:ecommerce/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

Container enjoyBar(BuildContext context, {required String text}) {
  return Container(

    child: SizedBox(
      height: 70,
      width: MediaQuery.sizeOf(context).width,
      child:  Row(
   //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Spacer(),
          Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'DancingScript',
                fontSize: 35,

              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileView(),),);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                width: 40,
                child: Image.asset(
                  'assets/images/user_avatar.png',
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}