import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bookly_app/features/auth/presentation/managers/auth_cubit.dart';
import 'package:my_bookly_app/features/splach/presentation/splach_view.dart';

void main() async {
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(Dio()),
      child: MaterialApp(
        routes: {
          '/': (context) => const SplashView(),
        },
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Ubuntu',
        ),
      ),
    );
  }
}
