import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_scanner/data/repositories/stock_scan_repository.dart';
import 'package:stock_market_scanner/logic/global/global_cubit.dart';
import 'package:stock_market_scanner/logic/variable/variable_cubit.dart';
import 'package:stock_market_scanner/presentation/pages/error_page.dart';
import 'package:stock_market_scanner/presentation/pages/loading_page.dart';
import 'package:stock_market_scanner/presentation/screens/home_screen.dart';
import 'package:stock_market_scanner/presentation/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => StockScanRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  GlobalCubit(context.read<StockScanRepository>())),
          BlocProvider(create: (context) => VariableCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
          ),
          home: BlocBuilder<GlobalCubit, GlobalState>(
            buildWhen: (previous, current) =>
                previous.stockScanResponse != current.stockScanResponse,
            builder: (context, state) {
              if (state.responseStatus == ResponseStatus.success) {
                return HomeScreen(stockScanResponse: state.stockScanResponse);
              } else if (state.responseStatus == ResponseStatus.error) {
                return const ErrorPage();
              }
              return const LoadingPage();
            },
          ),
        ),
      ),
    );
  }
}
