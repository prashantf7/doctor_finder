

import 'dart:io';


import 'package:doctor_finder/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

 
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      state = AsyncValue.error(
        'Ensure all details are filled!',
        StackTrace.current,
      );
      return;
    }

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref
          .read(authRepositoryProvider)
          .signInWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
    });
  }

  // ---------------------------------------------------------
  // Register App User
  // ---------------------------------------------------------

  Future<void> createAppUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required File profileImage,
    required String location,
    required double latitude,
    required double longitude,
    required String type,
  }) async {
    if (email.trim().isEmpty ||
        password.trim().isEmpty ||
        name.trim().isEmpty ||
        phoneNumber.trim().isEmpty ||
        type.trim().isEmpty ||
        location.trim().isEmpty) {
      state = AsyncValue.error(
        'Ensure all details are filled!',
        StackTrace.current,
      );
      return;
    }

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider)
          .createAppUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
            name: name.trim(),
            phoneNumber: phoneNumber.trim(),
            profileImage: profileImage,
            location: location.trim(),
            latitude: latitude,
            longitude: longitude,
            type: type.trim(),
          );
    });
  }

  // ---------------------------------------------------------
  // Register Doctor
  // ---------------------------------------------------------

  Future<void> createDoctorWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required File profileImage,
    required String location,
    required double latitude,
    required double longitude,
    required String type,
    required String specialization,
    required String description,
    required int yearsOfExperience,
  }) async {
    if (email.trim().isEmpty ||
        password.trim().isEmpty ||
        name.trim().isEmpty ||
        phoneNumber.trim().isEmpty ||
        type.trim().isEmpty ||
        location.trim().isEmpty ||
        specialization.trim().isEmpty ||
        description.trim().isEmpty) {
      state = AsyncValue.error(
        'Ensure all details and the image are selected!',
        StackTrace.current,
      );
      return;
    }

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).createDoctorWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
            name: name.trim(),
            phoneNumber: phoneNumber.trim(),
            profileImage: profileImage,
            location: location.trim(),
            latitude: latitude,
            longitude: longitude,
            type: type.trim(),
            specialization: specialization.trim(),
            description: description.trim(),
            yearsOfExperience: yearsOfExperience,
          );
    });
  }
}
