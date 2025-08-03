import 'package:dynamicformapp/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// A simple class to hold the display name and the value for a dropdown item.
class AppDropdownMenuItem {
  final String name;
  final dynamic value;

  AppDropdownMenuItem({required this.name, required this.value});
}

class AppDropdownButton extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final dynamic value; // Can be any type now
  final List<AppDropdownMenuItem> items; // Use the new class
  final Function(dynamic value)? onChanged; // Can be any type now
  final String? Function(dynamic value)? validator;
  final Color? fillColor;
  final Color? textColor;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final String? errorText;

  const AppDropdownButton({
    this.hintText,
    this.labelText,
    this.value,
    required this.items,
    this.onChanged,
    this.validator,
    this.fillColor,
    this.textColor,
    this.readOnly = false,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
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
        DropdownButtonFormField<dynamic>(
          // Use dynamic type
          value: value,
          focusNode: focusNode,
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
              borderSide: const BorderSide(color: greyColor, width: 3.0),
            ),
            filled: true,
            prefixIcon: prefixIcon,
            fillColor: fillColor ?? greyColor,
            suffixIcon: suffixIcon,
          ),
          // Map the AppDropdownMenuItem list to DropdownMenuItem widgets
          items: items.map((AppDropdownMenuItem item) {
            return DropdownMenuItem<dynamic>(
              value: item.value,
              child: Text(item.name),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
