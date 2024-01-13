import 'package:flutter/material.dart';

import 'constants.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "Muli",
      appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black)),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: kTextColor),
        bodyMedium: TextStyle(color: kTextColor),
        bodySmall: TextStyle(color: kTextColor),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );
  }
}

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(28)),
  borderSide: BorderSide(color: kTextColor),
  gapPadding: 10,
);

// ThemeData theme() {
//   return ThemeData(
//       fontFamily: 'Raleway',
//       primarySwatch: Colors.pink,
//       colorScheme: ColorScheme.fromSwatch(
//           primarySwatch: Colors.pink, accentColor: Colors.amber),
//       canvasColor: const Color.fromRGBO(255, 254, 229, 1),
//       textTheme: ThemeData.light().textTheme.copyWith(
//           titleLarge: const TextStyle(
//               fontFamily: 'RobotoCondensed',
//               fontSize: 20,
//               fontWeight: FontWeight.bold),
//           bodyLarge: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
//           bodyMedium: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)))
//       // scaffoldBackgroundColor: Palette.dimWhite,
//       // primarySwatch: Palette.buildMaterialColor(Palette.primary),
//       // primaryColor: Palette.primary,
//       // fontFamily: GoogleFonts.inter().fontFamily,
//       // visualDensity: VisualDensity.adaptivePlatformDensity,
//       // appBarTheme: appBarTheme(),
//       // textTheme: textTheme(),
//       // inputDecorationTheme: inputDecorationTheme(),
//       // elevatedButtonTheme: elevatedButtonTheme(),
//       // unselectedWidgetColor: Palette.primary,
//       // bottomNavigationBarTheme: bottomNavigationBarTheme()
//       );
// }
