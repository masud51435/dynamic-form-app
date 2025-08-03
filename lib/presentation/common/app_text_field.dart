import 'package:dynamicformapp/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final Color? fillColor;
  final Color? textColor;
  final bool readOnly;
  final bool obscureText;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final TextInputType? keyBoardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final String? initialValue, errorText;

  const AppTextField({
    this.keyBoardType,
    this.hintText,
    this.labelText,
    this.controller,
    this.onChanged,
    this.validator,
    this.fillColor,
    this.textColor,
    this.readOnly = false,
    this.obscureText = false,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines,
    this.maxLength = 20,
    this.inputFormatters,
    this.focusNode,
    this.initialValue,
    this.errorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: GoogleFonts.ubuntu(
              color: darkColor.withOpacity(0.3),
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (labelText != null) const SizedBox(height: 6.0),
        TextFormField(
          controller: controller,
          keyboardType: keyBoardType,
          readOnly: readOnly,
          onTap: onTap,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          focusNode: focusNode,
          initialValue: initialValue,
          onChanged: onChanged,
          maxLength: maxLength, // Apply maxLength if provided
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 10.0,
            ),
            errorText: errorText,
            hintText: hintText,
            hintStyle: TextStyle(
              color: darkColor.withOpacity(0.3),
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: const BorderSide(color: greyColor, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide(color: greyColor, width: 3.0),
            ),
            filled: true,
            prefixIcon: prefixIcon,
            fillColor: fillColor ?? greyColor,
            suffixIcon: suffixIcon,
            counterText: '',
          ),
          validator: validator,
          maxLines: maxLines,
        ),
      ],
    );
  }
}
