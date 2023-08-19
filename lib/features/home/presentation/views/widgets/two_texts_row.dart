import 'package:flutter/material.dart';

Row twoTextsRow({required String fText,required String sText}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        fText,
        style: const TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      TextButton(
        onPressed: () {},
        child:  Text(
          sText,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    ],
  );
}