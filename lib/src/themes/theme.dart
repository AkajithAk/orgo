import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinycolor/tinycolor.dart';
import '../models/blocks_model.dart';
import '../ui/blocks/hex_color.dart';

class GalleryThemeData {

  static ThemeData lightThemeData(BuildContext context, AppTheme theme, AppTypography typography) =>
      themeDataLight(context, theme, typography);
  static ThemeData darkThemeData(BuildContext context, AppTheme theme, AppTypography typography) => themeDataDark(context, theme, typography);

  static ThemeData lightArabicThemeData(BuildContext context, AppTheme theme, AppTypography typography) =>
      themeArabicDataLight(context, theme, typography);
  static ThemeData darkArabicThemeData = themeArabicDataDark();

  static ThemeData themeDataLight(BuildContext context, AppTheme theme, AppTypography typography) {

    MaterialColor primarySwatch = _getPrimarySwatch(theme.primarySwatch);
    Color buttonColor = HexColor(theme.buttonColor);
    Color primaryColor = HexColor(theme.primaryColor).toString() == 'Color(0xffffffff)' ? Colors.white : HexColor(theme.primaryColor);
    Color accentColor = HexColor(theme.accentColor);

    return ThemeData(
      primarySwatch: primarySwatch,
      primaryColor: primaryColor,
      accentColor: accentColor,
      primaryTextTheme: GoogleFonts.robotoTextTheme(ThemeData(primaryColor: primaryColor).primaryTextTheme),
      textTheme: GoogleFonts.robotoTextTheme(ThemeData(brightness: Brightness.light).textTheme),
      accentTextTheme: GoogleFonts.robotoTextTheme(ThemeData(accentColor: accentColor).accentTextTheme),
      appBarTheme: AppBarTheme(
        //textTheme: _textTheme.apply(bodyColor: Colors.white),
        //color: Colors.white,
        elevation: 0.0,
        //iconTheme: IconThemeData(color: Colors.white),
        //brightness: Brightness.dark,
      ),
      //primaryIconTheme: IconThemeData(color: Colors.black),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.black,
        labelColor: Colors.black),
        buttonTheme: ButtonThemeData(
        buttonColor: buttonColor,
        //shape: StadiumBorder(),
        textTheme: ButtonTextTheme.primary,
        height: 45.0,
        colorScheme: new ColorScheme(
            primary: buttonColor,
            primaryVariant: buttonColor.brighten(5),
            secondary: Color(0xff03dac6),
            secondaryVariant: const Color(0xff018786),
            surface: buttonColor.isDark ? Colors.white : Colors.black,
            background: Colors.white,
            error: Color(0xffb00020),
            onPrimary: buttonColor.isDark ? Colors.white : Colors.black,
            onSecondary: Colors.black,
            onSurface: Colors.black,
            onBackground: Colors.black,
            onError: Colors.white,
            brightness: buttonColor.isDark ? Brightness.dark : Brightness.light
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static ThemeData themeDataDark(BuildContext context, AppTheme theme, AppTypography typography) {
    ThemeData theme = ThemeData(brightness: Brightness.dark);
    return ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.robotoTextTheme(theme.textTheme),
        primaryTextTheme: GoogleFonts.robotoTextTheme(theme.primaryTextTheme),
        accentTextTheme: GoogleFonts.robotoTextTheme(theme.accentTextTheme),
        buttonTheme: ButtonThemeData(
          buttonColor:Color(0xff03dac6),
          //shape: StadiumBorder(),
          textTheme: ButtonTextTheme.primary,
          height: 45.0,
          colorScheme: new ColorScheme(
              primary: Color(0xff03dac6),
              primaryVariant: const Color(0xff03dac6),
              secondary: const Color(0xff03dac6),
              secondaryVariant: const Color(0xff03dac6),
              background: const Color(0xff000000),
              surface: const Color(0xff121212),
              error: Color(0xffb00020),
              onPrimary: Colors.black,
              onSecondary: Colors.black,
              onSurface: Colors.black,
              onBackground: Colors.black,
              onError: Colors.white,
              brightness: Brightness.light),
        ),
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.black,
        cardColor: Colors.black87
    );
  }

  static ThemeData themeArabicDataLight(BuildContext context, AppTheme theme, AppTypography typography) {

    MaterialColor primarySwatch = _getPrimarySwatch(theme.primarySwatch);
    Color buttonColor = HexColor(theme.buttonColor);
    Color primaryColor = HexColor(theme.primaryColor).toString() == 'Color(0xffffffff)' ? Colors.white : HexColor(theme.primaryColor);
    Color accentColor = HexColor(theme.accentColor);

    return ThemeData(
      primarySwatch: primarySwatch,
      primaryColor: primaryColor,
      accentColor: accentColor,
      //*** For White App Bar ***/
      //primaryTextTheme: _textTheme.apply(bodyColor: Colors.black),
      appBarTheme: AppBarTheme(
        //textTheme: _textTheme.apply(bodyColor: Colors.white),
        //color: Colors.white,
        elevation: 0.0,
        //iconTheme: IconThemeData(color: Colors.white),
        //brightness: Brightness.dark,
      ),
      //primaryIconTheme: IconThemeData(color: Colors.black),
      tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.black,
          labelColor: Colors.black),
      buttonTheme: ButtonThemeData(
        buttonColor: buttonColor,
        //shape: StadiumBorder(),
        textTheme: ButtonTextTheme.primary,
        height: 45.0,
        colorScheme: new ColorScheme(
            primary: buttonColor,
            primaryVariant: buttonColor.brighten(5),
            secondary: Color(0xff03dac6),
            secondaryVariant: const Color(0xff018786),
            surface: buttonColor.isDark ? Colors.white : Colors.black,
            background: Colors.white,
            error: Color(0xffb00020),
            onPrimary: buttonColor.isDark ? Colors.white : Colors.black,
            onSecondary: Colors.black,
            onSurface: Colors.black,
            onBackground: Colors.black,
            onError: Colors.white,
            brightness: buttonColor.isDark ? Brightness.dark : Brightness.light
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
    );
  }

  static ThemeData themeArabicDataDark() {
    return ThemeData(
        brightness: Brightness.dark,
        buttonTheme: ButtonThemeData(
          buttonColor:Color(0xff03dac6),
          //shape: StadiumBorder(),
          textTheme: ButtonTextTheme.primary,
          height: 45.0,
          colorScheme: new ColorScheme(
              primary: Color(0xff03dac6),
              primaryVariant: const Color(0xff03dac6),
              secondary: const Color(0xff03dac6),
              secondaryVariant: const Color(0xff03dac6),
              background: const Color(0xff000000),
              surface: const Color(0xff121212),
              error: Color(0xffb00020),
              onPrimary: Colors.black,
              onSecondary: Colors.black,
              onSurface: Colors.black,
              onBackground: Colors.black,
              onError: Colors.white,
              brightness: Brightness.light),
        ),
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.black,
        backgroundColor: Colors.black,
        cardColor: Colors.black87
    );
  }
}


_getPrimarySwatch(s) {
  switch (s) {
    case 'Colors.red':
      {
        return Colors.red;
      }
      break;

    case 'Colors.pink':
      {
        return Colors.pink;
      }
      break;

    case 'Colors.purple':
      {
        return Colors.purple;
      }
      break;

    case 'Colors.deepPurple':
      {
        return Colors.deepPurple;
      }
      break;

    case 'Colors.indigo':
      {
        return Colors.indigo;
      }
      break;

    case 'Colors.blue':
      {
        return Colors.blue;
      }
      break;

    case 'Colors.lightBlue':
      {
        return Colors.lightBlue;
      }
      break;

    case 'Colors.cyan':
      {
        return Colors.cyan;
      }
      break;

    case 'Colors.teal':
      {
        return Colors.teal;
      }
      break;

    case 'Colors.green':
      {
        return Colors.green;
      }
      break;

    case 'Colors.lightGreen':
      {
        return Colors.lightGreen;
      }
      break;

    case 'Colors.lime':
      {
        return Colors.lime;
      }
      break;

    case 'Colors.yellow':
      {
        return Colors.yellow;
      }
      break;

    case 'Colors.amber':
      {
        return Colors.amber;
      }
      break;

    case 'Colors.orange':
      {
        return Colors.orange;
      }
      break;

    case 'Colors.deepOrange':
      {
        return Colors.deepOrange;
      }
      break;

    case 'Colors.brown':
      {
        return Colors.brown;
      }
      break;

    case 'Colors.blueGrey':
      {
        return Colors.blueGrey;
      }
      break;

    default:
      {
        return Colors.blue;
      }
      break;
  }
}