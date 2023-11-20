import 'package:flutter/material.dart';

class Insets {
  static const double xsmall = 4;
  static const double small = 8;
  static const double medium = 12;
  static const double large = 16;
  static const double extraLarge = 24;
  static const double xxLarge = 32;

  static const EdgeInsets button = EdgeInsets.only(bottom: extraLarge);

  static const EdgeInsets formInput = EdgeInsets.only(bottom: medium);

  static const EdgeInsets topPadding = EdgeInsets.only(bottom: extraLarge);

  static const EdgeInsets onboardingHeader =
      EdgeInsets.only(top: 32.0, bottom: Insets.medium);

  static const EdgeInsets titleHeader = EdgeInsets.only(
    left: Insets.large,
    right: Insets.large,
  );

  static const EdgeInsets titleDescription = EdgeInsets.only(
    left: Insets.large,
    right: Insets.large,
    top: Insets.medium,
    bottom: Insets.medium,
  );

  static const EdgeInsets inBetweenPadding = EdgeInsets.only(
    left: Insets.small,
    right: Insets.small,
    top: Insets.small,
    bottom: Insets.small,
  );

  static const EdgeInsets rootContent =
      EdgeInsets.only(left: large, right: large);

  static const EdgeInsets smallContent = EdgeInsets.all(small);
}
