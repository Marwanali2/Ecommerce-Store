import 'package:flutter/material.dart';

import '../utils/colors.dart';

Container enjoyBar(BuildContext context, {required String text}) {
  return Container(
    decoration: const BoxDecoration(
      color: mainColor,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(
          100,
        ),
        bottomRight: Radius.circular(
          100,
        ),
      ),
    ),
    height: 70,
    child: SizedBox(
      height: 70,
      width: MediaQuery.sizeOf(context).width,
      child:  Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'DancingScript',
            fontSize: 35,
          ),
        ),
      ),
    ),
  );
}