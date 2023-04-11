import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

//================ Primary Color ================
const defaultColor = Color.fromRGBO(93, 63, 211, 1);

//================ Dark Theme Colors ================
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  // =================== Light Mode Theme ======================
  static final lightTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(background: Colors.white),
    primaryColor: defaultColor,
    brightness: Brightness.light,
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
  );

  // =================== Dark Mode Theme ======================
  static final darkTheme = ThemeData.dark().copyWith(
    // primaryColor: darkGreyClr,
    colorScheme: const ColorScheme.dark(background: darkGreyClr),
    brightness: Brightness.dark,
    bottomAppBarTheme: const BottomAppBarTheme(color: darkGreyClr),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: defaultColor,
        size: 25,
      ),
      centerTitle: true,
      elevation: 0,
    ),
  );
}

// =================== Fonts ======================
TextStyle get appBarTitleStyle {
  return GoogleFonts.inter(
    textStyle: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black,
      letterSpacing: 0.7,
    ),
  );
}

TextStyle get headingLarge {
  return GoogleFonts.inter(
    textStyle: const TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
      color: defaultColor,
      letterSpacing: 0.5,
    ),
  );
}

TextStyle get bodyLarge {
  return GoogleFonts.inter(
    textStyle: TextStyle(
      fontSize: 18,
      color: Get.isDarkMode ? Colors.white : Colors.black,
      letterSpacing: 0.5,
    ),
  );
}

TextStyle get bodySmall {
  return GoogleFonts.inter(
    textStyle: TextStyle(
      fontSize: 15,
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontWeight: FontWeight.w400,
    ),
  );
}

TextStyle get caption {
  return GoogleFonts.inter(
    textStyle: const TextStyle(
      fontSize: 12,
      color: Colors.grey,
      height: 1.7,
    ),
  );
}



// TextStyle get inputFieldHintStyle {
//   return GoogleFonts.inter(
//     textStyle: const TextStyle(
//       fontSize: 18,
//       // fontWeight: FontWeight.bold,
//       color: Colors.grey,
//       letterSpacing: 0.5,
//     ),
//   );
// }
