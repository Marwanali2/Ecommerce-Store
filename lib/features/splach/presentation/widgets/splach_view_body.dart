import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/constants.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  debugPrint() {
    'token is $userToken';
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        seconds: 10,
      ),
      () {
        /*  (userToken.isEmpty||userToken=="")?
     GoRouter.of(context).pushReplacement(AppRouter.kLoginView):
      GoRouter.of(context).pushReplacement(AppRouter.kLayoutView);*/
        GoRouter.of(context).pushReplacement(AppRouter.kLayoutView);
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView(),));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100.h,
          ),
          Lottie.asset(
            'assets/lottie_json_animations/splash.json',
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'All what you need in one place',
            style: TextStyle(fontSize: 28.sp, fontFamily: 'DancingScript'),
          ),
          const Spacer(),
          Text(
            'Developed By Marwan Ali',
            style: TextStyle(fontSize: 15.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
