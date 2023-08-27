import 'package:ecommerce/features/auth/presentation/views/login_view.dart';
import 'package:ecommerce/features/home/presentation/views/home_view.dart';
import 'package:ecommerce/features/shared/network/local_network.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/constants.dart';
import '../../../auth/presentation/views/register_view.dart';
import '../../../layout/presentation/views/layout_view.dart';
import '../../../profile/presentation/views/profile_view.dart';


class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  debugPrint() {
    'token is $userToken';
  }
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 10,),() {
      (userToken.isEmpty||userToken=="")?
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginView(),)):
     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LayoutView(),)):
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LayoutView(),));
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileView(),));
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView(),));
    },);
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100,),
          Lottie.asset(
            'assets/lottie_json_animations/splash.json',
          ),
          const SizedBox(height: 10,),
          const Text('All what you need in one place',style: TextStyle(fontSize: 30,fontFamily: 'DancingScript'),),
          const Spacer(),
          const Text('Developed By Marwan Ali',style: TextStyle(fontSize: 15,color: Colors.grey),),
        ],
      ),
    );
  }
}
