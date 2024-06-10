import 'package:flutter/cupertino.dart';

class Responsive {
  static late double _screenWidth;
  static late double _screenHeight;
  static double _blockSizeHorizontal = 0;
  static double _blockSizeVertical = 0;

  static late double text;
  static late double icon;
  static late double height;
  static late double width;
  static late bool isTablet;
  static late bool isDesktop;

  static late bool isMobile;

  void init(BoxConstraints constraints, Orientation orientation) {
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;

    if (constraints.maxWidth < 450) {
      isMobile = true;
      isTablet = false;
      isDesktop = false;
    } else if (constraints.maxWidth < 900 && constraints.maxWidth >= 450) {
      isTablet = true;
      isMobile = false;
      isDesktop = false;
    } else if (constraints.maxWidth >= 900) {
      isDesktop = true;
      isMobile = false;
      isTablet = false;
    }

    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;

    text = _blockSizeVertical;
    icon = _blockSizeHorizontal;
    height = _blockSizeVertical;
    width = _blockSizeHorizontal;
  }
}

Widget wGap([double? w]) {
  return SizedBox(
    width: (w ?? 0) * Responsive.width,
  );
}

Widget hGap([double? h]) {
  return SizedBox(
    height: (h ?? 0) * Responsive.height,
  );
}
