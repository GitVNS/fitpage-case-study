import 'package:flutter/material.dart';
import 'package:stock_market_scanner/data/models/stock_scan_response.dart';
import 'package:stock_market_scanner/data/services/color_definer.dart';
import 'package:stock_market_scanner/presentation/pages/error_page.dart';
import 'package:stock_market_scanner/presentation/screens/buying_seen_screen.dart';
import 'package:stock_market_scanner/presentation/screens/cci_screen.dart';
import 'package:stock_market_scanner/presentation/screens/open_high_screen.dart';
import 'package:stock_market_scanner/presentation/screens/rsi_screen.dart';
import 'package:stock_market_scanner/presentation/screens/top_gainers_screen.dart';
import 'package:stock_market_scanner/presentation/utils/app_colors.dart';
import 'package:stock_market_scanner/presentation/widgets/title_card.dart';

class HomeScreen extends StatelessWidget {
  final List<StockScanResponse> stockScanResponse;
  const HomeScreen({super.key, required this.stockScanResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBgColor,
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          physics: const BouncingScrollPhysics(),
          itemCount: stockScanResponse.length,
          itemBuilder: (context, index) {
            return TitleCard(
              title: stockScanResponse[index].name,
              subTitle: stockScanResponse[index].tag,
              subtitleColor: getSubTitleColor(stockScanResponse[index].color),
              onTap: () {
                MaterialPageRoute pageRoute = getRoute(index);
                Navigator.of(context).push(pageRoute);
              },
            );
          },
        ),
      ),
    );
  }

  MaterialPageRoute getRoute(int index) {
    switch (index) {
      case 0:
        return MaterialPageRoute(
            builder: (_) =>
                TopGainersScreen(stockScanResponse: stockScanResponse[index]));
      case 1:
        return MaterialPageRoute(
            builder: (_) =>
                BuyingSeenScreen(stockScanResponse: stockScanResponse[index]));
      case 2:
        return MaterialPageRoute(
            builder: (_) =>
                OpenHighScreen(stockScanResponse: stockScanResponse[index]));
      case 3:
        return MaterialPageRoute(
            builder: (_) =>
                CCIScreen(stockScanResponse: stockScanResponse[index]));
      case 4:
        return MaterialPageRoute(
            builder: (_) =>
                RSIScreen(stockScanResponse: stockScanResponse[index]));
      default:
        return MaterialPageRoute(builder: (_) => const ErrorPage());
    }
  }
}
