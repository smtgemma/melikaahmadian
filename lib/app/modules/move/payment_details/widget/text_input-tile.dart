import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInputTitle extends StatelessWidget {
  const TextInputTitle({
    super.key,
    required this.controllerValue,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.isNumberOnly = false,
  });

  final RxString controllerValue;
  final String label;
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final bool isNumberOnly;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextField(
        keyboardType:
        isNumberOnly ? TextInputType.number : keyboardType,
        textAlign: textAlign,
        style: GoogleFonts.dmSans(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.dmSans(
            color: Colors.white70,
            fontSize: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white24),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white70),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: (value) => controllerValue.value = value,
      );
    });
  }
}
