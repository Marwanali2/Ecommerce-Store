import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../main.dart';
class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({Key? key}) : super(key: key);

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('xz'),
            Spacer(),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  EcommerceApp.appLanguage='en';
                });

              },
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(color9)
              ),
              child: const Text(
                'EN',
                style: TextStyle(
                  color:  Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(width: 1.w,),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  EcommerceApp.appLanguage='ar';
                });

              },
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(10)
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(color9)
              ),
              child: const Text(
                'AR',
                style: TextStyle(
                  color:  Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
