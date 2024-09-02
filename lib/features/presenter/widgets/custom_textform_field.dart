import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:send_money_assessment/features/presenter/widgets/app_color.dart';

class MyCustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? initialValue;

  final TextInputType? inputType;
  final bool? isObsecure;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double paddingHeight;

  // final List<TextInputFormatter>? inputFormatters

  final Function(String value)? onChangeTextForm;
  final Function(String value)? validatorText;

  const MyCustomTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.initialValue,
    this.isObsecure,
    this.inputType,
    this.suffixIcon,
    this.prefixIcon,
    this.paddingHeight = 12,
    this.onChangeTextForm,
    this.validatorText,
  });

  @override
  Widget build(BuildContext context) {
    final logger = Logger();
    List<TextInputFormatter> inputFormatters = [];

    if (inputType == const TextInputType.numberWithOptions(decimal: true)) {
      // logger.d(inputType);
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
      ];
    }
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      keyboardType: inputType,
      onChanged: onChangeTextForm != null
          ? (value) => onChangeTextForm!(value)
          : null, // Ad

      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: AppColors.mainBgColor,
          contentPadding: EdgeInsetsDirectional.symmetric(
              horizontal: 18, vertical: paddingHeight),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColorDark),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black87),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColorDark),
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }
}
