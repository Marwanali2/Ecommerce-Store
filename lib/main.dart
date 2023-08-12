import 'package:flutter/material.dart';
import 'package:my_bookly_app/features/splach/presentation/splach_view.dart';

void main() async{


  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/':(context) => const SplashView(),
      },
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Ubuntu',
      ),
    );
  }
}
