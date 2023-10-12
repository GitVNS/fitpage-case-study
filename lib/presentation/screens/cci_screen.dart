import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_scanner/data/models/stock_scan_response.dart';
import 'package:stock_market_scanner/data/services/color_definer.dart';
import 'package:stock_market_scanner/logic/variable/variable_cubit.dart';
import 'package:stock_market_scanner/presentation/utils/app_colors.dart';
import 'package:stock_market_scanner/presentation/widgets/spacers.dart';
import 'package:stock_market_scanner/presentation/widgets/title_card.dart';

class CCIScreen extends StatelessWidget {
  final StockScanResponse stockScanResponse;
  const CCIScreen({super.key, required this.stockScanResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBgColor,
      body: BlocBuilder<VariableCubit, VariableState>(
          buildWhen: (p, c) =>
              p.cciPeriod != c.cciPeriod || p.cciValue != c.cciValue,
          builder: (context, state) {
            return SafeArea(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
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
                          text: criterion.text,
                          rw1: state.cciPeriod != null
                              ? state.cciPeriod!.toInt().toString()
                              : '20',
                          rw2: state.cciValue != null
                              ? state.cciValue!.toInt().toString()
                              : '100')),
                    ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        const Text('Period'),
                        horizontalSpacer(space: 16),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                filled: true,
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                            onChanged: (value) {
                              final number = int.tryParse(value);
                              var min = stockScanResponse
                                  .criteria[0].variable!.the1!.minValue!;
                              var max = stockScanResponse
                                  .criteria[0].variable!.the1!.maxValue!;
                              if (number != null) {
                                if (number >= min && number <= max) {
                                  context
                                      .read<VariableCubit>()
                                      .changeCCIPeriod(number.toDouble());
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpacer(space: 16),
                  for (double value
                      in stockScanResponse.criteria[0].variable!.the2!.values!)
                    GestureDetector(
                      onTap: () {
                        context.read<VariableCubit>().changeCCIValue(value);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: state.cciValue == value
                                ? AppColors.customBlue
                                : null,
                            border: Border.all(
                                width: 1, color: AppColors.onBgColor)),
                        child: Text(value.toInt().toString()),
                      ),
                    ),
                ],
              ),
            );
          }),
    );
  }

  String getInfo(
      {required String text, required String rw1, required String rw2}) {
    int indexOfCrosses = text.indexOf('crosses');
    int indexOfBelow = text.indexOf('below');
    String result =
        '${text.substring(0, 3)} $rw1 ${text.substring(indexOfCrosses, indexOfBelow + 5)} $rw2';
    return result;
  }
}
