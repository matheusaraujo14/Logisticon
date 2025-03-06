import 'package:flutter/material.dart';

class FontSizes {
  final double screenWidth;
  final double screenHeight;

  FontSizes(BuildContext context)
      : screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height;

  double get size => screenHeight > screenWidth
      ? screenHeight > 2000
          ? screenHeight
          : screenHeight > 1800
              ? 1800
              : screenHeight > 1600
                  ? 1600
                  : screenHeight > 1400
                      ? 1400
                      : 1200
      : screenWidth > 1900
          ? screenWidth
          : screenWidth > 1600
              ? 1900
              : 1700;

  double get extraExtraExtraSmall => size * 0.011;
  double get extraExtraSmall => size * 0.013;
  double get extraSmall => size * 0.015;
  double get small => size * 0.017;
  double get medium => size * 0.019;
  double get large => size * 0.021;
  double get extraLarge => size * 0.023;
  double get extraExtraLarge => size * 0.025;
  double get extraExtraExtraLarge => size * 0.027;
}

class ContainerSizes {
  final double screenWidth;
  final double screenHeight;

  ContainerSizes(BuildContext context)
      : screenWidth = MediaQuery.of(context).size.width,
        screenHeight = MediaQuery.of(context).size.height;

  double get small => screenWidth * 0.3;
  double get medium => screenWidth * 0.5;
  double get large => screenWidth * 0.9;
}
