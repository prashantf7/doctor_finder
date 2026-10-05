import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<String> _listOfSpecializations = [
    'Eyes',
    'Ears',
    'Nose',
    'Teeth',
    'Limbs',
  ];

  final specializationProvider = Provider<List<String>>((ref) {
    return _listOfSpecializations;
  });