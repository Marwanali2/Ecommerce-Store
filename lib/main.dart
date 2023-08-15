import 'package:ecommerce/features/auth/presentation/managers/auth_cubit.dart';
import 'package:ecommerce/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/shared/network/local_network.dart';
import 'features/splach/presentation/splach_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();//ensureInitialized() function is used to ensure that the Flutter framework is properly initialized before executing any code that depends on it
  await CachedNetwork.cacheInitialization();
  Bloc.observer = SimpleBlocObserver();
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(),),
      ],
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
