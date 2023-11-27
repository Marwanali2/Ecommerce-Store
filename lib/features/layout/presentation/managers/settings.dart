import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/colors.dart';
import '../../../../generated/l10n.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({Key? key}) : super(key: key);

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                S.of(context).selectLang,
                style: TextStyle(
                  color: color4,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  //  Navigator.push(context, MaterialPageRoute(builder: (conext) => LayoutView(),));
                  S.load(const Locale('en'));
                  setState(() {});
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    backgroundColor: Intl.getCurrentLocale() == 'en'
                        ? const MaterialStatePropertyAll(color9)
                        : const MaterialStatePropertyAll(Colors.blueGrey)),
                child: const Text(
                  'EN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              ElevatedButton(
                onPressed: () {
                  S.load(const Locale('ar'));
                  setState(() {});
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    backgroundColor: Intl.getCurrentLocale() == 'ar'
                        ? const MaterialStatePropertyAll(color9)
                        : const MaterialStatePropertyAll(Colors.blueGrey)),
                child: const Text(
                  'AR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            children: [
              Text(
                S.of(context).changeTheme,
                style: TextStyle(
                  color: color4,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
