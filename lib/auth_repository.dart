

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_finder/app_user_model.dart';

import 'package:doctor_finder/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';



part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._auth);

  final FirebaseAuth _auth;

  // Sign in
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Register a normal AppUser
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
    // Register the user
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = cred.user;

    if (user == null) {
      throw Exception('User registration failed.');
    }

    // Upload profile image
    final firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child(user.uid);

    final snapshot = await firebaseStorageRef.putFile(profileImage);

    // Get download URL
    final profileImageUrl = await snapshot.ref.getDownloadURL();

    // Create AppUser
    final appUser = AppUser(
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      imageUrl: profileImageUrl,
      location: location,
      latitude: latitude,
      longitude: longitude,
      userId: user.uid,
      type: type,
    );

    // Save to Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(appUser.toMap());
  }

  // Register a doctor
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
    // Register the user
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = cred.user;

    if (user == null) {
      throw Exception('Doctor registration failed.');
    }

    // Upload profile image
    final firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child(user.uid);

    final snapshot = await firebaseStorageRef.putFile(profileImage);

    // Get download URL
    final profileImageUrl = await snapshot.ref.getDownloadURL();

    // Create Doctor
    final doctor = Doctor(
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      imageUrl: profileImageUrl,
      location: location,
      latitude: latitude,
      longitude: longitude,
      userId: user.uid,
      type: type,
      specialization: specialization,
      description: description,
      yearsOfExperience: yearsOfExperience,
    );

    // Save to Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(doctor.toMap());
  }

  // Current Firebase user
  User? get currentUser {
    return _auth.currentUser;
  }

  // Authentication state changes
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}


 
@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(FirebaseAuth.instance);
}

@Riverpod(keepAlive: true)
Stream<User?> authStateChanges(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}

@riverpod
User? currentUser(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.currentUser;
}
