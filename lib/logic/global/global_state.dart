part of 'global_cubit.dart';

class GlobalState extends Equatable {
  final ResponseStatus responseStatus;
  final List<StockScanResponse> stockScanResponse;

  @override
  List<Object?> get props => [responseStatus, StockScanResponse];

  const GlobalState(
      {this.responseStatus = ResponseStatus.initial,
      this.stockScanResponse = const []});

  GlobalState copyWith({
    ResponseStatus? responseStatus,
    List<StockScanResponse>? stockScanResponse,
  }) {
    return GlobalState(
        responseStatus: responseStatus ?? this.responseStatus,
        stockScanResponse: stockScanResponse ?? this.stockScanResponse);
  }
}
