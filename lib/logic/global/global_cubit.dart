import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market_scanner/data/models/stock_scan_response.dart';
import 'package:stock_market_scanner/data/repositories/stock_scan_repository.dart';
import 'package:stock_market_scanner/presentation/utils/constants.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  final StockScanRepository stockScanRepository;
  GlobalCubit(this.stockScanRepository) : super(const GlobalState()) {
    getData();
  }

  void getData() async {
    emit(state.copyWith(responseStatus: ResponseStatus.fetching));
    if (state.responseStatus == ResponseStatus.success) return;
    emit(state.copyWith(responseStatus: ResponseStatus.fetching));
    var response = await stockScanRepository.getData();
    var status =
        response != null ? ResponseStatus.success : ResponseStatus.error;
    emit(state.copyWith(responseStatus: status, stockScanResponse: response));
  }
}
