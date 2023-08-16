import 'package:flutter/material.dart';

import '../utils/colors.dart';

Container EnjoyBar(BuildContext context) {
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
      child: const Center(
        child: Text(
          'Enjoy our products',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'DancingScript',
            fontSize: 35,
          ),
        ),
      ),
    ),
  );
}