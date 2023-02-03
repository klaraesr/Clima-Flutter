import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

const primary = Color(0xff004D53);
const accentColor = Color(0xff56bc93);
const attention = Color(0xffF26624);
const secondary = Color(0xff839992);

const disabledColor = Color(0xff5d6562);
const dividerThemeColor = Color(0xffdedede);
const headlineFontFamily = 'Bely';
const defaultFontFamily = 'Jost';

class AppTheme {
  static const BackgroundColor = Color(0xffFCFCFC);
  static const DefaultPaddingSize = 20.0;
  static const DefaultPadding = EdgeInsets.symmetric(horizontal: DefaultPaddingSize, vertical: DefaultPaddingSize);

  // Breakpoints
  // https://docs.google.com/spreadsheets/d/1gN_NhPdMbj4_Exqx5gEiovOmWDTsW9xlOUvchJCvZGc/
  // Talk to design before introducing new ones.
  static const double smallDeviceHeight = 736.0;

  final ThemeData theme = ThemeData(
    fontFamily: defaultFontFamily,
    colorScheme: ColorScheme.fromSeed(seedColor: primary),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(
        fontSize: 60,
        fontWeight: FontWeight.w900,
      ),
      displayMedium: GoogleFonts.montserrat(
        fontSize: 40,
        fontWeight: FontWeight.w900,
      ),
      displaySmall: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
      labelLarge: GoogleFonts.montserrat(
        fontSize: 60,
      ),
    ),
  );

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.height <= AppTheme.smallDeviceHeight;
  }
}
