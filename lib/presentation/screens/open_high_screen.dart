import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_scanner/data/models/stock_scan_response.dart';
import 'package:stock_market_scanner/data/services/color_definer.dart';
import 'package:stock_market_scanner/logic/variable/variable_cubit.dart';
import 'package:stock_market_scanner/presentation/utils/app_colors.dart';
import 'package:stock_market_scanner/presentation/widgets/spacers.dart';
import 'package:stock_market_scanner/presentation/widgets/title_card.dart';

class OpenHighScreen extends StatelessWidget {
  final StockScanResponse stockScanResponse;
  const OpenHighScreen({super.key, required this.stockScanResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBgColor,
      body: BlocBuilder<VariableCubit, VariableState>(
        buildWhen: (p, c) => p.openHighVariable != c.openHighVariable,
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
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
                    subtitleColor: getSubTitleColor(stockScanResponse.color),
                  ),
                  verticalSpacer(space: 16),
                  for (Criterion criterion in stockScanResponse.criteria)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(getInfo(
                          criterion.text,
                          state.openHighVariable != null
                              ? state.openHighVariable!.toInt().toString()
                              : '\$1')),
                    ),
                  for (double value
                      in stockScanResponse.criteria[0].variable!.the1!.values!)
                    GestureDetector(
                      onTap: () {
                        context
                            .read<VariableCubit>()
                            .changeOpenHighVariable(value);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: state.openHighVariable == value
                                ? AppColors.customBlue
                                : null,
                            border: Border.all(
                                width: 1, color: AppColors.onBgColor)),
                        child: Text(value.toInt().toString()),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String getInfo(String text, String replaceWith) {
    int indexOfBy = text.indexOf('by');
    String result = '${text.substring(0, indexOfBy + 2)} $replaceWith %';
    return result;
  }
}
