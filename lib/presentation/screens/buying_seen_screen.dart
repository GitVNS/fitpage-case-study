import 'package:flutter/material.dart';
import 'package:stock_market_scanner/data/models/stock_scan_response.dart';
import 'package:stock_market_scanner/data/services/color_definer.dart';
import 'package:stock_market_scanner/data/services/csv_loader.dart';
import 'package:stock_market_scanner/presentation/utils/app_colors.dart';
import 'package:stock_market_scanner/presentation/utils/constants.dart';
import 'package:stock_market_scanner/presentation/widgets/spacers.dart';
import 'package:stock_market_scanner/presentation/widgets/title_card.dart';

class BuyingSeenScreen extends StatelessWidget {
  final StockScanResponse stockScanResponse;
  const BuyingSeenScreen({super.key, required this.stockScanResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBgColor,
      body: SafeArea(
        child: FutureBuilder(
          future: CSVLoader.loadData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TitleCard(
                        title: stockScanResponse.name,
                        subTitle: stockScanResponse.tag,
                        cardBgColor: AppColors.customBlue.withOpacity(0.5),
                        margin: 0,
                        subtitleColor:
                            getSubTitleColor(stockScanResponse.color),
                      ),
                      verticalSpacer(space: 16),
                      for (Criterion criterion in stockScanResponse.criteria)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(criterion.text),
                        ),
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(3),
                          2: FlexColumnWidth(3),
                          3: FlexColumnWidth(3),
                          4: FlexColumnWidth(2),
                          5: FlexColumnWidth(3),
                          6: FlexColumnWidth(3),
                        },
                        border: TableBorder.all(
                            color: AppColors.tableColor,
                            borderRadius: BorderRadius.circular(8)),
                        children: snapshot.data!.map((item) {
                          return TableRow(
                              decoration: BoxDecoration(
                                  color: AppColors.onBgColor,
                                  borderRadius: BorderRadius.circular(8)),
                              children: item.map((row) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    row.toString(),
                                    style: const TextStyle(
                                        color: AppColors.customWhite),
                                  ),
                                );
                              }).toList());
                        }).toList(),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    'No Data',
                    style: TextStyle(color: AppColors.customWhite),
                  ),
                );
              }
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text(wentWrong,
                    style: TextStyle(color: AppColors.customRed)),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.customWhite,
                backgroundColor: AppColors.onBgColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
