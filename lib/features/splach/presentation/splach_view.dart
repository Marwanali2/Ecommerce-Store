import 'package:flutter/material.dart';
import 'package:my_bookly_app/features/splach/presentation/widgets/splach_view_body.dart';
class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SplashViewBody(),
      ),
    );
  }
}
