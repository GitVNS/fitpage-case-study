import 'package:flutter/material.dart';
import 'package:stock_market_scanner/presentation/utils/app_colors.dart';
import 'package:stock_market_scanner/presentation/widgets/spacers.dart';

class TitleCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color titleColor;
  final Color subtitleColor;
  final Color? cardBgColor;
  final double margin;
  final VoidCallback? onTap;
  const TitleCard({
    super.key,
    required this.title,
    required this.subTitle,
    this.titleColor = AppColors.customWhite,
    this.subtitleColor = AppColors.customGreen,
    this.cardBgColor,
    this.margin = 8,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 10,
        color: cardBgColor ?? AppColors.onBgColor,
        margin: EdgeInsets.all(margin),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: titleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              verticalSpacer(space: 16),
              Text(
                subTitle,
                style: TextStyle(color: subtitleColor, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
