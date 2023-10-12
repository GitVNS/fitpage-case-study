import 'package:flutter/material.dart';
import 'package:stock_market_scanner/presentation/utils/app_colors.dart';

Color getSubTitleColor(String color) {
  switch (color) {
    case 'green':
      return AppColors.customGreen;
    case 'red':
      return AppColors.customRed;
    default:
      return AppColors.customWhite;
  }
}
