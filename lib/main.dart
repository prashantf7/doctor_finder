import 'package:doctor_finder/app_styles.dart';
import 'package:doctor_finder/firebase_options.dart';
// import 'package:doctor_finder/home_screen.dart';
import 'package:doctor_finder/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: AppStyles.mainColor,
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
        ),
      ),
      routerConfig: router,
    );
  }
}
