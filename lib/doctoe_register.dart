  import 'dart:io';

import 'package:doctor_finder/app_styles.dart';
import 'package:doctor_finder/common_button.dart';
import 'package:doctor_finder/common_container.dart';
import 'package:doctor_finder/common_text_field.dart';
import 'package:doctor_finder/routes.dart';
import 'package:doctor_finder/size_config.dart';
import 'package:doctor_finder/specialization_list.dart';
  
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class DoctorRegister extends ConsumerStatefulWidget {
  const DoctorRegister({super.key});

  @override
  ConsumerState<DoctorRegister> createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends ConsumerState<DoctorRegister> {
  final _emailEditingController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _yearsOfExperienceController = TextEditingController();

  File? _selectedImage;

  String? _selectedSpecialization;

    void _takePicture() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _yearsOfExperienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
  final listofSpecializations = ref.watch(specializationProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyles.mainColor,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            SizeConfig.getProportionateWidth(10),
            SizeConfig.getProportionateHeight(50),
            SizeConfig.getProportionateWidth(10),
            0,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/doclogo.png',
                    height: SizeConfig.getProportionateHeight(100),
                    width: SizeConfig.getProportionateWidth(100),
                    fit: BoxFit.cover,
                  ),

                  Text(
                    'Doctor Registration',
                    style: AppStyles.titleTextStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),

                  const Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),

                  SizedBox(
                    height: SizeConfig.getProportionateHeight(15),
                  ),

                  GestureDetector(
                    onTap: _takePicture,
                    child: CircleAvatar(
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : const AssetImage(
                              'assets/images/placeholder.png',
                            ) as ImageProvider,
                      radius: SizeConfig.getProportionateHeight(60),
                    ),
                  ),

                  SizedBox(
                    height: SizeConfig.getProportionateHeight(10),
                  ),

                  CommonTextField(
                    hintText: 'Enter Name...',
                    textInputType: TextInputType.name,
                    controller: _nameController,
                  ),

                  SizedBox(
                    height: SizeConfig.getProportionateHeight(10),
                  ),

                  CommonTextField(
                    hintText: 'Enter Phone Number...',
                    textInputType: TextInputType.phone,
                    controller: _phoneNumberController,
                  ),

                  SizedBox(
                    height: SizeConfig.getProportionateHeight(10),
                  ),

                  CommonTextField(
                    hintText: 'Enter Your Description...',
                    textInputType: TextInputType.multiline,
                    controller: _descriptionController,
                  ),

                  SizedBox(
                    height: SizeConfig.getProportionateHeight(10),
                  ),

                  CommonTextField(
                    hintText: 'Enter Years of Experience...',
                    textInputType: TextInputType.number,
                    controller: _yearsOfExperienceController,
                  ),

                  SizedBox(
                    height: SizeConfig.getProportionateHeight(10),
                  ),

                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select Specialization',
                      labelStyle: AppStyles.normalTextStyle.copyWith(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    initialValue: _selectedSpecialization,
                    items: listofSpecializations.map(
                      (String group) {
                        return DropdownMenuItem<String>(
                          value: group,
                          child: Text(
                            group,
                            style: AppStyles.normalTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSpecialization = newValue;
                      });
                    },
                  ),

                  SizedBox(
                    height: SizeConfig.getProportionateHeight(10),
                  ),

                  CommonTextField(
                    hintText: 'Enter Location...',
                    textInputType: TextInputType.streetAddress,
                    controller: _locationController,
                  ),

                  SizedBox(
                    height: SizeConfig.getProportionateHeight(10),
                  ),

                  CommonTextField(
                    hintText: 'Enter Email...',
                    textInputType: TextInputType.emailAddress,
                    controller: _emailEditingController,
                  ),

                  SizedBox(
                    height: SizeConfig.getProportionateHeight(10),
                  ),

                  CommonTextField(
                    hintText: 'Enter Password...',
                    textInputType: TextInputType.text,
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  CommonButton(onTap: (){}, title: 'Register Me', isLoading: false), SizedBox(
                    height: SizeConfig.getProportionateHeight(10),
                  ),
                  Text(
                    'Or',
                    style: AppStyles.normalTextStyle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                   SizedBox(
                    height: SizeConfig.getProportionateHeight(10),
                  ),
                  CommonContainer(onTap: () {
                    context.goNamed(AppRoutes.signIn.name);
                  }, text: 'Sign in to my account'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
