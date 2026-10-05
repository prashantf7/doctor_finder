import 'package:doctor_finder/app_styles.dart';
import 'package:doctor_finder/size_config.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  const CommonButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.isLoading,
  });

  final VoidCallback onTap;
  final String title;
  final bool isLoading;

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return InkWell(
      onTap: widget.isLoading ? null : widget.onTap,
      child: Container(
        alignment: Alignment.center,
        height: SizeConfig.getProportionateHeight(50),
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: AppStyles.mainColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: widget.isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                widget.title,
                style: AppStyles.normalTextStyle,
              ),
      ),
    );
  }
}
