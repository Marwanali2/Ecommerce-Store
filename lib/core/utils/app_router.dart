import 'package:ecommerce/core/utils/constants.dart';
import 'package:ecommerce/features/auth/presentation/views/login_view.dart';
import 'package:ecommerce/features/auth/presentation/views/register_view.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/product_details_view.dart';
import 'package:ecommerce/features/layout/presentation/views/layout_view.dart';
import 'package:ecommerce/features/splach/presentation/on_boarding.dart';
import 'package:ecommerce/main.dart';
import 'package:go_router/go_router.dart';

import '../../features/profile/presentation/views/profile_view.dart';
import '../../features/splach/presentation/splach_view.dart';

abstract class AppRouter {
  static const kLoginView = '/loginView';
  static const kSignUpView = '/signUpView';
  static const kSplashView = '/splashView';
  static const kLayoutView = '/layoutView';
  static const kHomeView = '/homeView';
  static const kProductDetailsView = '/ProductDetailsView';
  static const kProfileView = '/profileView';
  static const kAppView = '/EcommerceApp';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => (userToken.isEmpty || userToken == "")
            ? const OnBoardingView()
            : const SplashView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => LoginView(),
      ),
      GoRoute(
        path: kSignUpView,
        builder: (context, state) => RegisterView(),
      ),
      GoRoute(
        path: kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kLayoutView,
        builder: (context, state) => const LayoutView(),
      ),
      GoRoute(
        path: kProductDetailsView,
        builder: (context, state) => const ProductDetailsView(),
      ),
      GoRoute(
        path: kProfileView,
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: kAppView,
        builder: (context, state) => const EcommerceApp(),
      ),
    ],
  );
}
