/*
* ✔ handle clear button in search bar
* show category products length in for each category categories view body
* handle custom error widget in favorites view body
* handle favorite button wow effect
* */
import 'package:ecommerce/core/utils/constants.dart';
import 'package:ecommerce/features/auth/presentation/managers/auth_cubit.dart';
import 'package:ecommerce/features/card/presentation/managers/carts_cubit.dart';
import 'package:ecommerce/features/card/presentation/views/widgets/checkout_view.dart';
import 'package:ecommerce/features/home/presentation/managers/categories_cubit/categories_cubit.dart';
import 'package:ecommerce/features/home/presentation/managers/products_cubit/products_cubit.dart';
import 'package:ecommerce/features/stripe_payment/stripe_keys.dart';
import 'package:ecommerce/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'features/favorites/presentation/managers/favorites_cubit/favorites_cubit.dart';
import 'features/home/presentation/managers/banner_cubit/banner_cubit.dart';
import 'features/layout/presentation/managers/layout_cubit.dart';
import 'features/layout/presentation/views/layout_view.dart';
import 'features/profile/presentation/managers/user_data_cubit.dart';
import 'features/shared/network/local_network.dart';
import 'features/splach/presentation/splach_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();//ensureInitialized() function is used to ensure that the Flutter framework is properly initialized before executing any code that depends on it
  await CachedNetwork.cacheInitialization();
  Bloc.observer = SimpleBlocObserver();
  debugPrint('user token is :$userToken');
  Stripe.publishableKey=StripeApiKeys.publishableKey;
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(),),
        BlocProvider(create: (context) => LayoutCubit(),),
        BlocProvider(create: (context) => BannerCubit()..getBanners(),),
        BlocProvider(create: (context) => CategoriesCubit()),
        BlocProvider(create: (context) => ProductsCubit()..getProducts(),),
        BlocProvider(create: (context) => FavoritesCubit()..getFavorites(),),
        BlocProvider(create: (context) => CartsCubit()..getCarts(),),
        BlocProvider( create: (context) => UserDataCubit()..getUserData(),),
        //BlocProvider(create: (context) => SearchCubit()..searchProducts(),),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          routes: {
            '/': (context) =>  const SplashView(),
          },
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Ubuntu',
          ),
        ),
      ),
    );
  }
}
