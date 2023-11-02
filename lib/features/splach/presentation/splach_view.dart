import 'package:flutter/material.dart';

import 'widgets/splach_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SplashViewBody(),
      ),
    );
  }
}
