import 'package:doctor_finder/size_config.dart';
import 'package:flutter/material.dart';

class AppStyles {

  static final headingTextStyle = TextStyle(
    fontSize: SizeConfig.getProportionateHeight(20),
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'Madimi One',
  );
  static final titleTextStyle = TextStyle(
    fontSize: SizeConfig.getProportionateHeight(18),
    fontWeight: FontWeight.w600,
    fontFamily: 'Madimi One',
    color: Colors.white,
  );
  static final normalTextStyle = TextStyle(
    fontSize: SizeConfig.getProportionateHeight(15),
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontFamily: 'Madimi One',
  );
  static const mainColor = Color(0xFF1591EA);
}
