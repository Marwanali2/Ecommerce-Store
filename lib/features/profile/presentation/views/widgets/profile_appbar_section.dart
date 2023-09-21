import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';
class SimpleAppBarSection extends StatelessWidget {
  const SimpleAppBarSection({
    super.key, required this.pageName,
  });
  final String pageName;
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
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(width: MediaQuery.sizeOf(context).width*0.28,),
             Text(
              pageName,
              style: const TextStyle(
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