import 'package:doctor_finder/app_styles.dart';
import 'package:doctor_finder/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoAnimation;
  late Animation<Offset> _textAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _textAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    navigateToNextScreen();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo animation
            SlideTransition(
              position: _logoAnimation,
              child: Image.asset('assets/images/doclogo.png', width: 150),
            ), // SlideTransition
            // Spacer between Logo and text
            const SizedBox(height: 20),
            // Text animation
            SlideTransition(
              position: _textAnimation,
              child: Text(
                'Find Doctors near you!',
                style: AppStyles.titleTextStyle,
              ),
            ),
            SlideTransition(
              position: _logoAnimation,
              child: Text(
                'No More Doctor Trouble',
                style: AppStyles.normalTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    if (hasSeenOnboarding) {
      if (!mounted) return;
      context.goNamed(AppRoutes.signIn.name);
    } else {
      if (!mounted) return;

      context.goNamed(AppRoutes.onboarding.name);
    }
  }
}
