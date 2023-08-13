import 'package:ecommerce/features/auth/presentation/managers/auth_cubit.dart';
import 'package:ecommerce/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/splach/presentation/splach_view.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const SplashView(),
      },
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Ubuntu',
      ),
    );
  }
}
