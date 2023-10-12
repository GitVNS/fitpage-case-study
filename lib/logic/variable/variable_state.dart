part of 'variable_cubit.dart';

class VariableState extends Equatable {
  final double? openHighVariable;
  final double? cciPeriod;
  final double? cciValue;
  final double? rsiCloseBy;
  final double? rsiPrev;
  final double? rsiSMA;
  final double? rsiPeriod;

  @override
  List<Object?> get props => [
        openHighVariable,
        cciPeriod,
        cciValue,
        rsiCloseBy,
        rsiPrev,
        rsiSMA,
        rsiPeriod
      ];

  const VariableState(
      {this.openHighVariable,
      this.cciPeriod,
      this.cciValue,
      this.rsiCloseBy,
      this.rsiPrev,
      this.rsiPeriod,
      this.rsiSMA});

  VariableState copyWith({
    double? openHighVariable,
    double? cciPeriod,
    double? cciValue,
    double? rsiCloseBy,
    double? rsiPrev,
    double? rsiSMA,
    double? rsiPeriod,
  }) {
    return VariableState(
      openHighVariable: openHighVariable ?? this.openHighVariable,
      cciPeriod: cciPeriod ?? this.cciPeriod,
      cciValue: cciValue ?? this.cciValue,
      rsiCloseBy: rsiCloseBy ?? this.rsiCloseBy,
      rsiPeriod: rsiPeriod ?? this.rsiPeriod,
      rsiPrev: rsiPrev ?? this.rsiPrev,
      rsiSMA: rsiSMA ?? this.rsiSMA,
    );
  }
}
