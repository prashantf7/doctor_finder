import 'package:doctor_finder/app_styles.dart';
import 'package:doctor_finder/common_button.dart';
import 'package:doctor_finder/common_container.dart';
import 'package:doctor_finder/common_text_field.dart';
import 'package:doctor_finder/routes.dart';
import 'package:doctor_finder/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ), // BoxDecoration
          child: Column(
            children: [
              Image.asset('assets/images/doclogo.png', width: 150),
              Text(
                'Sign In to your account',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              CommonTextField(
                hintText: 'email',
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              CommonTextField(
                hintText: 'password',
                textInputType: TextInputType.text,
                obscureText: true,
                controller: _passwordController,
              ),
              CommonButton(onTap: () {}, title: 'Sign In', isLoading: false),

              SizedBox(height: SizeConfig.getProportionateHeight(15)),
              Text(
                'OR',
                style: AppStyles.titleTextStyle.copyWith(color: Colors.black),
              ), // Text
              SizedBox(height: SizeConfig.getProportionateHeight(15)),
              CommonContainer(
                onTap: () {
                   context.goNamed(AppRoutes.userRegister.name);
                },
                text: 'Register as user',
              ),
                  SizedBox(height: SizeConfig.getProportionateHeight(15)),
              CommonContainer(
                onTap: () {
                  context.goNamed(AppRoutes.doctorRegister.name);
                },
                text: 'Register as doctor',
              ),
              SizedBox(height: SizeConfig.getProportionateHeight(30)),
            ],
          ), // Column
        ), // Container,
      ),
    );
  }
}
