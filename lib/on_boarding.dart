import 'package:doctor_finder/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      "title": "Welcome to Our App",
      "description": "Discover Doctors near you",
      "image": "assets/images/doclogo.png",
    },
    {
      "title": "Connect with Doctors",
      "description": "Book appointments with a doctor",
      "image": "assets/images/doclogo.png",
    },
    {
      "title": "Get Started",
      "description": "Sign In to continue",
      "image": "assets/images/doclogo.png",
    },
  ];
  void _onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void _skip() {
    _completeOnboarding();
  }

  void _completeOnboarding() async {
    // Save onboarding completion status in shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasseenonboarding', true);

    // Navigate to the next screen (e.g., SignInScreen)
    Navigator.pushReplacementNamed(context, '/signin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(_pages[index]["image"]!, height: 250),
                  const SizedBox(height: 20),
                  Text(
                    _pages[index]["title"]!,
                    style: AppStyles.headingTextStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      _pages[index]["description"]!,
                      textAlign: TextAlign.center,
                      style: AppStyles.titleTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(left: 0,right: 0,bottom: 80,
            child: Row(
              children: List.generate(
                _pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentPage == index ? 12 : 8,
                  height: currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index
                        ? AppStyles.mainColor
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: currentPage == _pages.length - 1
                ? ElevatedButton(
                    onPressed: _completeOnboarding,
                    child: const Text("Get Started"),
                  )
                : TextButton(onPressed: _skip, child: const Text("Skip")),
          ),
        ],
      ),
    );
  }
}

//      Scaffold(
// body: Stack(
// children: [
// PageView.builder (
// controller: _pageController,
// itemCount: _pages.length,
// onPageChanged: _onPageChanged,
// itemBuilder: (context, index) {
// return Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Image.asset(_pages[index] ["image"]!, height: 250),
// const SizedBox(height: 20),
// Text(

// _pages[index][ "title"]!,
// style: AppStyles.headingTextStyle
// .copyWith(color: Colors.black),
// ), // Text
// const SizedBox(height: 10),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 30),
// child: Text(
// _pages[index] ["description"]!,
// textAlign: TextAlign.center,
// style: AppStyles.titleTextStyle
// .copyWith(color: Colors.black),
// ), // Text
// ), // Padding
// ], /
// );
// },
// ),
// ];)
