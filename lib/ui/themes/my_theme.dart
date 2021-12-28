import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get myLightTheme {
  /// Initialize ThemeData.
  var theme = ThemeData(
    primarySwatch: Colors.lightGreen,
    brightness: Brightness.light,
  );

  /// Main Setting.
  theme = theme.copyWith(
    colorScheme: theme.colorScheme.copyWith(
      onSecondary: const Color(0xffffff00),
      onPrimary: const Color(0xff5e35b1),
      primary: const Color(0xffffd54f),
      secondary: const Color(0xffff8a80),
    ),
    textTheme: theme.textTheme.copyWith(
      button:
          GoogleFonts.getFont('Montserrat', textStyle: theme.textTheme.button),
      caption:
          GoogleFonts.getFont('Montserrat', textStyle: theme.textTheme.caption),
      overline: GoogleFonts.getFont('Montserrat',
          textStyle: theme.textTheme.overline),
      bodyText1: GoogleFonts.getFont('Montserrat',
          textStyle: theme.textTheme.bodyText1),
      bodyText2: GoogleFonts.getFont('Montserrat',
          textStyle: theme.textTheme.bodyText2),
      headline1:
          GoogleFonts.getFont('Roboto', textStyle: theme.textTheme.headline1),
      headline2:
          GoogleFonts.getFont('Roboto', textStyle: theme.textTheme.headline2),
      headline3:
          GoogleFonts.getFont('Roboto', textStyle: theme.textTheme.headline3),
      headline4:
          GoogleFonts.getFont('Roboto', textStyle: theme.textTheme.headline4),
      headline5:
          GoogleFonts.getFont('Roboto', textStyle: theme.textTheme.headline5),
      headline6:
          GoogleFonts.getFont('Roboto', textStyle: theme.textTheme.headline6),
      subtitle1: GoogleFonts.getFont('Montserrat',
          textStyle: theme.textTheme.subtitle1),
      subtitle2: GoogleFonts.getFont('Montserrat',
          textStyle: theme.textTheme.subtitle2),
    ),
  );

  /// ElevatedButton Setting.
  theme = theme.copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (!states.contains(MaterialState.disabled)) {
            return const Color(0xffe57373);
          }
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (!states.contains(MaterialState.disabled)) {
            return const Color(0xfff8bbd0);
          }
        }),
        shadowColor: MaterialStateProperty.resolveWith((states) {
          if (!states.contains(MaterialState.disabled)) {
            return const Color(0xff1a237e);
          }
        }),
        elevation: MaterialStateProperty.resolveWith((states) {
          if (!states.contains(MaterialState.disabled)) {
            return 5.0;
          }
        }),
        padding: MaterialStateProperty.all(
          const EdgeInsets.only(
            top: 16.0,
            left: 44.0,
            right: 44.0,
            bottom: 16.0,
          ),
        ),
        side: MaterialStateProperty.resolveWith(
          (states) {
            var isDisabled = states.contains(MaterialState.disabled);
            return BorderSide(
              color: (isDisabled)
                  ? const Color(0xff00e676).withOpacity(.15)
                  : const Color(0xff00e676),
              width: 2.0,
            );
          },
        ),
        shape: MaterialStateProperty.all(
          const BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(29.0),
              bottomLeft: Radius.circular(60.0),
              topRight: Radius.circular(14.0),
              bottomRight: Radius.circular(28.0),
            ),
          ),
        ),
      ),
    ),
  );

  /// OutlinedButton Setting.
  theme = theme.copyWith(
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (!states.contains(MaterialState.disabled)) {
            return const Color(0xffe57373);
          }
        }),
        overlayColor:
            MaterialStateProperty.all(const Color(0xffe57373).withOpacity(.15)),
        padding: MaterialStateProperty.all(
          const EdgeInsets.only(
            top: 16.0,
            left: 44.0,
            right: 44.0,
            bottom: 16.0,
          ),
        ),
        side: MaterialStateProperty.resolveWith(
          (states) {
            var isDisabled = states.contains(MaterialState.disabled);
            return BorderSide(
              color: (isDisabled)
                  ? const Color(0xffce93d8).withOpacity(.15)
                  : const Color(0xffce93d8),
              width: 4.0,
            );
          },
        ),
        shape: MaterialStateProperty.all(
          const BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(29.0),
              bottomLeft: Radius.circular(60.0),
              topRight: Radius.circular(14.0),
              bottomRight: Radius.circular(28.0),
            ),
          ),
        ),
      ),
    ),
  );

  /// TextButton Setting.
  theme = theme.copyWith(
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (!states.contains(MaterialState.disabled)) {
            return const Color(0xffe57373);
          }
        }),
        overlayColor:
            MaterialStateProperty.all(const Color(0xffe57373).withOpacity(.15)),
      ),
    ),
  );

  /// Chip Setting.
  theme = theme.copyWith(
    chipTheme: theme.chipTheme.copyWith(
      deleteIconColor: const Color(0xffb71c1c),
      disabledColor: const Color(0xffd6d6d6),
      selectedColor: const Color(0xff00acc1),
      secondarySelectedColor: const Color(0xfff9a825),
      checkmarkColor: const Color(0xfff4ff81),
      padding: const EdgeInsets.only(
        top: 15.0,
        left: 13.0,
        right: 13.0,
        bottom: 15.0,
      ),
      side: const BorderSide(
        color: Color(0xffffeb3b),
        width: 3.0,
        style: BorderStyle.solid,
      ),
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(57.0),
          bottomLeft: Radius.circular(54.0),
          topRight: Radius.circular(57.0),
          bottomRight: Radius.circular(54.0),
        ),
      ),
      labelStyle: GoogleFonts.getFont(
        'Montserrat',
        textStyle: theme.chipTheme.labelStyle,
        color: const Color(0xff01579b),
        fontSize: 14.0,
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.italic,
        letterSpacing: 3.6,
        wordSpacing: 3.9,
        height: 1.0,
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 1.0,
            color: Color(0xfff9a825),
            offset: Offset(1.7, 1.0),
          )
        ],
      ),
      secondaryLabelStyle: GoogleFonts.getFont(
        'Montserrat',
        textStyle: theme.chipTheme.labelStyle,
        color: const Color(0xff1a237e),
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
        height: 2.7,
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 2.0,
            color: Color(0xffb9f6ca),
            offset: Offset(1.4, 1.3),
          )
        ],
      ),
      pressElevation: 5.0,
    ),
  );

  /// CheckBox Setting.
  theme = theme.copyWith(
    checkboxTheme: theme.checkboxTheme.copyWith(
      checkColor: MaterialStateProperty.all(const Color(0xffb3e5fc)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (!states.contains(MaterialState.disabled)) {
          return const Color(0xff5d4037);
        } else {
          return const Color(0xff5d4037).withOpacity(.25);
        }
      }),
    ),
  );

  /// Radio Setting.
  theme = theme.copyWith(
    radioTheme: theme.radioTheme.copyWith(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (!states.contains(MaterialState.disabled)) {
          return const Color(0xff5d4037);
        } else {
          return const Color(0xff5d4037).withOpacity(.25);
        }
      }),
    ),
  );

  /// Switch Setting.
  theme = theme.copyWith(
    switchTheme: theme.switchTheme.copyWith(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (!states.contains(MaterialState.disabled) &&
            states.contains(MaterialState.selected)) {
          return const Color(0xff5d4037);
        }
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (!states.contains(MaterialState.disabled) &&
            states.contains(MaterialState.selected)) {
          return const Color(0xff5d4037).withOpacity(.25);
        }
      }),
    ),
  );

  /// Slider Setting.
  theme = theme.copyWith(
    sliderTheme: theme.sliderTheme.copyWith(
      inactiveTrackColor: const Color(0xffe65100),
      thumbColor: const Color(0xff84ffff),
      overlayColor: const Color(0xff84ffff).withOpacity(.15),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 11.0 * 2),
      thumbShape: const RoundSliderThumbShape(
        enabledThumbRadius: 11.0,
        elevation: 8.0,
      ),
      trackHeight: 15.0,
      valueIndicatorColor: const Color(0xffb388ff),
      activeTrackColor: const Color(0xff0d47a1),
    ),
  );

  /// TextBox Setting.
  theme = theme.copyWith(
    inputDecorationTheme: theme.inputDecorationTheme.copyWith(
      filled: true,
      fillColor: const Color(0xffbdbdbd),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(33.0),
          bottomLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
          bottomRight: Radius.circular(33.0),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(33.0),
          bottomLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
          bottomRight: Radius.circular(33.0),
        ),
        borderSide: BorderSide(
          color: Color(0xfff57f17),
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(33.0),
          bottomLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
          bottomRight: Radius.circular(33.0),
        ),
        borderSide: BorderSide(
          color: Color(0xff82b1ff),
          width: 3.0,
          style: BorderStyle.solid,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(33.0),
          bottomLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
          bottomRight: Radius.circular(33.0),
        ),
        borderSide: BorderSide(
          color: Color(0xffb9f6ca),
          width: 4.0,
          style: BorderStyle.solid,
        ),
      ),
    ),
  );

  /// Card Setting.
  theme = theme.copyWith(
    cardTheme: theme.cardTheme.copyWith(
      color: const Color(0xffd6d6d6),
      shadowColor: const Color(0xffff3d00),
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(19.0),
          bottomLeft: Radius.circular(21.0),
          topRight: Radius.circular(21.0),
          bottomRight: Radius.circular(19.0),
        ),
        side: BorderSide(
          color: Color(0xff388e3c),
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
    ),
  );

  /// Text Setting.
  theme = theme.copyWith(
    textTheme: theme.textTheme.copyWith(
      button: GoogleFonts.getFont(
        'Montserrat',
        textStyle: theme.textTheme.button,
        color: const Color(0xff1de9b6),
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.italic,
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 2.0,
            color: Color(0xffff3d00),
            offset: Offset(1.4, 2.1),
          )
        ],
      ),
      caption: GoogleFonts.getFont(
        'Montserrat',
        textStyle: theme.textTheme.caption,
        color: const Color(0xffe91e63),
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 2.0,
            color: Color(0xff512da8),
            offset: Offset(1.2, 1.2),
          )
        ],
      ),
      overline: GoogleFonts.getFont(
        'Montserrat',
        textStyle: theme.textTheme.overline,
        color: const Color(0xff2962ff),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 2.0,
            color: Color(0xff84ffff),
            offset: Offset(0.9, 1.0),
          )
        ],
      ),
      subtitle1: GoogleFonts.getFont(
        'Montserrat',
        textStyle: theme.textTheme.subtitle1,
        color: const Color(0xff18ffff),
        fontWeight: FontWeight.w200,
        fontStyle: FontStyle.italic,
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 3.0,
            color: Color(0xfff4511e),
            offset: Offset(1.3, 1.1),
          )
        ],
      ),
      subtitle2: (theme.textTheme.subtitle2 ?? const TextStyle()).copyWith(
        color: const Color(0xff263238),
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.italic,
        letterSpacing: 0.7,
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 2.0,
            color: Color(0xff64ffda),
            offset: Offset(0.7, 1.4),
          )
        ],
      ),
      bodyText1: (theme.textTheme.bodyText1 ?? const TextStyle()).copyWith(
        color: const Color(0xff82b1ff),
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 2.0,
            color: Color(0xffffee58),
            offset: Offset(1.1, 1.3),
          )
        ],
      ),
      bodyText2: (theme.textTheme.bodyText2 ?? const TextStyle()).copyWith(
        color: const Color(0xff9c27b0),
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 2.0,
            color: Color(0xff6d4c41),
            offset: Offset(1.1, 1.0),
          )
        ],
      ),
      headline1: GoogleFonts.getFont(
        'Montserrat',
        textStyle: theme.textTheme.headline1,
        color: const Color(0xff311b92),
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.italic,
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 3.0,
            color: Color(0xffff9e80),
            offset: Offset(0.8, 0.7),
          )
        ],
      ),
      headline2: GoogleFonts.getFont(
        'Montserrat',
        textStyle: theme.textTheme.headline2,
        color: const Color(0xffffff00),
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 2.0,
            color: Color(0xff1b5e20),
            offset: Offset(0.9, 1.3),
          )
        ],
      ),
      headline3: GoogleFonts.getFont(
        'Montserrat',
        textStyle: theme.textTheme.headline3,
        color: const Color(0xff004d40),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 2.0,
            color: Colors.yellow,
            offset: Offset(0.8, 0.8),
          )
        ],
      ),
      headline4: GoogleFonts.getFont(
        'Montserrat',
        textStyle: theme.textTheme.headline4,
        color: const Color(0xffb9f6ca),
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 2.0,
            color: Color(0xff3e2723),
            offset: Offset(1.0, 1.2),
          )
        ],
      ),
      headline5: GoogleFonts.getFont(
        'Montserrat',
        textStyle: theme.textTheme.headline5,
        color: const Color(0xffea80fc),
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 2.0,
            color: Color(0xffb9f6ca),
            offset: Offset(0.9, 0.6),
          )
        ],
      ),
      headline6: (theme.textTheme.headline6 ?? const TextStyle()).copyWith(
        color: const Color(0xffff5722),
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.italic,
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 2.0,
            color: Color(0xff42a5f5),
            offset: Offset(0.9, 1.2),
          )
        ],
      ),
    ),
  );

  /// Appbar Setting.
  theme = theme.copyWith(
    appBarTheme: theme.appBarTheme.copyWith(
      titleSpacing: 6.0,
      color: const Color(0xffab47bc),
      shadowColor: const Color(0xffffff00),
      centerTitle: true,
      iconTheme: (theme.appBarTheme.iconTheme ?? theme.iconTheme)
          .copyWith(color: const Color(0xff00acc1)),
      elevation: 2.0,
      textTheme: (const TextTheme()).copyWith(
        headline6: GoogleFonts.getFont(
          'Montserrat',
          textStyle: theme.textTheme.headline6,
          color: const Color(0xffab47bc),
          fontSize: 16.0,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          shadows: <Shadow>[
            const Shadow(
              blurRadius: 2.0,
              color: Color(0xffffff00),
              offset: Offset(2.4, 2.3),
            )
          ],
        ),
      ),
    ),
  );
  return theme;
}

// ThemeData get myDarkTheme {
//   // TODO: Copy Dark Theme Here.
//   return theme;
// }
