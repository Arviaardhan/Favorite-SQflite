import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color headerTextColor = Colors.black;
const Color hintTextColor = Color(0xFF8A8A8A);
const Color iconColor = Color(0xFF2D2D2D);
const Color borderColor = Color(0xFF656565);
const Color secondaryColor = Colors.white;
const Color viewDetailColor = Color(0xFF575757);
const Color titleTextColor = Color(0xFF262626);
const Color foodMenuColor = Color(0xFF767676);

figmaFontsize(int fontSize) {
  return fontSize * 0.95;
}

class AppThemesWeight {
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.bold;
}

TextStyle titleStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: titleTextColor,
        fontWeight: AppThemesWeight.semiBold,
        fontSize: figmaFontsize(15)
    )
);

TextStyle descStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: iconColor,
        fontWeight: AppThemesWeight.medium,
        fontSize: figmaFontsize(15)
    )
);