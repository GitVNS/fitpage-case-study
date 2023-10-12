import 'package:flutter/material.dart';
import 'package:stock_market_scanner/presentation/utils/app_colors.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBgColor,
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.customWhite,
          backgroundColor: AppColors.onBgColor,
        ),
      ),
    );
  }
}
