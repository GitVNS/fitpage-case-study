import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_scanner/data/models/stock_scan_response.dart';
import 'package:stock_market_scanner/data/services/color_definer.dart';
import 'package:stock_market_scanner/logic/variable/variable_cubit.dart';
import 'package:stock_market_scanner/presentation/pages/rsi_values_page.dart';
import 'package:stock_market_scanner/presentation/utils/app_colors.dart';
import 'package:stock_market_scanner/presentation/widgets/spacers.dart';
import 'package:stock_market_scanner/presentation/widgets/title_card.dart';

class RSIScreen extends StatefulWidget {
  final StockScanResponse stockScanResponse;
  const RSIScreen({super.key, required this.stockScanResponse});

  @override
  State<RSIScreen> createState() => _RSIScreenState();
}

class _RSIScreenState extends State<RSIScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBgColor,
      body: BlocBuilder<VariableCubit, VariableState>(
          buildWhen: (p, c) =>
              p.rsiCloseBy != c.rsiCloseBy ||
              p.rsiPeriod != c.rsiPeriod ||
              p.rsiPrev != c.rsiPrev ||
              p.rsiSMA != c.rsiSMA,
          builder: (context, state) {
            return SafeArea(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [
                  TitleCard(
                    title: widget.stockScanResponse.name,
                    subTitle: widget.stockScanResponse.tag,
                    cardBgColor: AppColors.customBlue.withOpacity(0.5),
                    margin: 0,
                    subtitleColor:
                        getSubTitleColor(widget.stockScanResponse.color),
                  ),
                  verticalSpacer(space: 16),
                  for (Criterion criterion in widget.stockScanResponse.criteria)
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (_) => RsiValuesPage(
                                      criterion: criterion,
                                    )))
                            .then((value) =>
                                value != null ? setState(() {}) : null);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.onBgColor)),
                        child: Text(criterion.text),
                      ),
                    ),
                ],
              ),
            );
          }),
    );
  }
}
