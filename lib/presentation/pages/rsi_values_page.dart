import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_scanner/data/models/stock_scan_response.dart';
import 'package:stock_market_scanner/logic/variable/variable_cubit.dart';
import 'package:stock_market_scanner/presentation/utils/app_colors.dart';
import 'package:stock_market_scanner/presentation/widgets/spacers.dart';

class RsiValuesPage extends StatelessWidget {
  final Criterion criterion;
  const RsiValuesPage({super.key, required this.criterion});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.screenBgColor,
        body: BlocBuilder<VariableCubit, VariableState>(
            buildWhen: (p, c) =>
                p.rsiCloseBy != c.rsiCloseBy ||
                p.rsiPeriod != c.rsiPeriod ||
                p.rsiPrev != c.rsiPrev ||
                p.rsiSMA != c.rsiSMA,
            builder: (context, state) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (criterion.text.contains('Max'))
                        for (double value in criterion.variable!.the1!.values!)
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<VariableCubit>()
                                  .changeRSICloseBy(value);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: state.rsiCloseBy == value
                                      ? AppColors.customBlue
                                      : null,
                                  border: Border.all(
                                      width: 1, color: AppColors.onBgColor)),
                              child: Text(value.toInt().toString()),
                            ),
                          ),
                      if (criterion.text.contains('Volume')) ...[
                        const Text('prev __'),
                        verticalSpacer(),
                        for (double value in criterion.variable!.the2!.values!)
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<VariableCubit>()
                                  .changeRSIPrev(value);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: state.rsiPrev == value
                                      ? AppColors.customBlue
                                      : null,
                                  border: Border.all(
                                      width: 1, color: AppColors.onBgColor)),
                              child: Text(value.toInt().toString()),
                            ),
                          ),
                        verticalSpacer(space: 16),
                        const Text('SMA by __'),
                        verticalSpacer(),
                        for (double value in criterion.variable!.the3!.values!)
                          GestureDetector(
                            onTap: () {
                              context.read<VariableCubit>().changeRSISMA(value);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: state.rsiSMA == value
                                      ? AppColors.customBlue
                                      : null,
                                  border: Border.all(
                                      width: 1, color: AppColors.onBgColor)),
                              child: Text(value.toString()),
                            ),
                          ),
                      ],
                      if (criterion.text.contains('RSI'))
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
                                    var min =
                                        criterion.variable!.the4!.minValue!;
                                    var max =
                                        criterion.variable!.the4!.maxValue!;
                                    if (number != null) {
                                      if (number >= min && number <= max) {
                                        context
                                            .read<VariableCubit>()
                                            .changeRSIPeriod(number.toDouble());
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
