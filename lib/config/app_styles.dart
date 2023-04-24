import 'package:flutter/material.dart';

Color primary = Colors.lightBlueAccent;

class Styles {
  static Color primaryColor = const Color.fromARGB(255, 207, 207, 207);
  static Color textColor = const Color.fromARGB(255, 212, 212, 212);
  static Color spacerColor = const Color.fromARGB(131, 160, 160, 160);
  static Color backgroundColor = const Color.fromARGB(255, 27, 27, 27);
  static Color navigationColor = const Color.fromARGB(99, 0, 0, 0);
  static Color navigationBackgroundColor = const Color.fromARGB(127, 0, 0, 0);
  static Color navigationButtonBackgroundColor =
      const Color.fromARGB(136, 0, 0, 0);
  static Color homeIconColor = Colors.greenAccent;
  static Color favoriteIconColor = Colors.redAccent;
  static List<Color> backgroundGradient = [Colors.black, Colors.lightBlue];
  static List<Color> bottomGradient = [
    Colors.lightBlue,
    Colors.black,
  ];
  static List<Color> appBarGradient = [
    Colors.black,
    Colors.lightBlue,
  ];

  static Color errorColor = Colors.amber;
  static Color loadingColor = Colors.purpleAccent;

  static Color focusedItemBorderColor = Colors.lightBlueAccent;
  static Color bordersColor = Colors.blueGrey;
  static Color formIconColor = const Color.fromARGB(255, 57, 101, 138);

  //movie details
  static Color floatingButtonBackgroundColor =
      const Color.fromARGB(124, 0, 125, 163);
  static List<Color> movieDetailsPosterGradientColor = const [
    Color.fromARGB(0, 0, 0, 0),
    Color.fromARGB(255, 0, 27, 58)
  ];
  static Color starColor = Colors.yellow;
  static Color favoriteColor = Colors.red;
  static Color notFavoriteColor = Colors.black;

  //movie search
  static Color filterRestoreColor = Colors.red;
}

class RadiusValue {
  static double inputFieldRadius = 10;
}

class Decorations {
  static BoxDecoration backgroundDecoration = BoxDecoration(
    gradient: SweepGradient(
      colors: Styles.backgroundGradient,
      center: Alignment.topLeft,
    ),
  );

  static BoxDecoration bottomNavigationDecoration = BoxDecoration(
    gradient: SweepGradient(
      colors: Styles.bottomGradient,
      center: Alignment.bottomRight,
    ),
  );

  static BoxDecoration appBarDecoration = BoxDecoration(
    gradient: SweepGradient(
      colors: Styles.bottomGradient,
      center: Alignment.bottomLeft,
    ),
  );
}
