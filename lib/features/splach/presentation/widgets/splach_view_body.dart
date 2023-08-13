import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_bookly_app/features/auth/presentation/views/register_view.dart';
import 'package:my_bookly_app/features/home/presentation/views/home_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override

  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 10,),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterView(),));
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
            'assets/lottie_json_animations/animation_ll7yt0ll.json',
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
