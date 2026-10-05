import 'package:doctor_finder/on_boarding.dart';
import 'package:doctor_finder/signin_screen.dart';
import 'package:doctor_finder/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'routes.g.dart';

enum AppRoutes {
  splash,
  onboarding,
  signIn,
  main,
  doctorRegister,
  userRegister,
  doctorDetails,
  account,
  chat,
  conversation,
}

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: AppRoutes.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: AppRoutes.onboarding.name,
        builder: (ctx, state) => const OnboardingScreen(),
      ), 
      GoRoute(
        path: '/signIn',
        name: AppRoutes.signIn.name,
        builder: (ctx, state) => const SignInScreen(),
      ),  
      // GoRoute(
      //   path: '/userRegister',
      //   name: AppRoutes.userRegister.name,
      //   builder: (ctx, state) => const UserRegister(),
      // ),  
      // GoRoute(
      //   path: '/signIn',
      //   name: AppRoutes.signIn.name,
      //   builder: (ctx, state) => const SignInScreen(),
      // ),  GoRoute(
      //   path: '/signIn',
      //   name: AppRoutes.signIn.name,
      //   builder: (ctx, state) => const SignInScreen(),
      // ),  GoRoute(
      //   path: '/signIn',
      //   name: AppRoutes.signIn.name,
      //   builder: (ctx, state) => const SignInScreen(),
      // ),  GoRoute(
      //   path: '/signIn',
      //   name: AppRoutes.signIn.name,
      //   builder: (ctx, state) => const SignInScreen(),
      // ),  GoRoute(
      //   path: '/signIn',
      //   name: AppRoutes.signIn.name,
      //   builder: (ctx, state) => const SignInScreen(),
      // ),  GoRoute(
      //   path: '/signIn',
      //   name: AppRoutes.signIn.name,
      //   builder: (ctx, state) => const SignInScreen(),
      // ),  GoRoute(
      //   path: '/signIn',
      //   name: AppRoutes.signIn.name,
      //   builder: (ctx, state) => const SignInScreen(),
      // ), 
    ],
  );
}
