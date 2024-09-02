import 'package:flutter/material.dart';
import 'package:send_money_assessment/features/presenter/widgets/app_color.dart';

class MyCustomizeButton extends StatelessWidget {
  final String buttonLabel;
  final Widget? buttonInfo;
  final Widget? suffixIcon;
  final Function() onPressedButton;

  final FontWeight labelFontWeight;
  final double labelFontSize;
  final Color labelColor;

  const MyCustomizeButton(
      {required this.buttonLabel,
      required this.onPressedButton,
      this.buttonInfo,
      this.suffixIcon,
      this.labelFontWeight = FontWeight.bold,
      this.labelFontSize = 18,
      this.labelColor = AppColors.mainColorDark,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: onPressedButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  buttonLabel,
                  style: TextStyle(
                      fontSize: labelFontSize,
                      fontWeight: labelFontWeight,
                      color: labelColor),
                ),
                buttonInfo ?? Container(),
              ],
            ),
            suffixIcon ?? Container()
          ],
        ),
      ),
    );
  }
}
