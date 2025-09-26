import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Styles {
  static final heading = GoogleFonts.luckiestGuy(
    textStyle: const TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.w400,
      height: 1.0,
      letterSpacing: 0.0,
      color: Colors.white,
    ),
  );

  static final text20 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
  );

  static final text18 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  static final text16 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  static final text14 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
  );

  static final titleMedium = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    ),
  );

  static final text30 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
  );
}
