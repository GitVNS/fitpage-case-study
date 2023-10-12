import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'variable_state.dart';

class VariableCubit extends Cubit<VariableState> {
  VariableCubit() : super(const VariableState());

  void changeOpenHighVariable(double value) {
    emit(state.copyWith(openHighVariable: value));
  }

  void changeCCIPeriod(double value) {
    emit(state.copyWith(cciPeriod: value));
  }

  void changeCCIValue(double value) {
    emit(state.copyWith(cciValue: value));
  }

  void changeRSICloseBy(double value) {
    emit(state.copyWith(rsiCloseBy: value));
  }

  void changeRSIPrev(double value) {
    emit(state.copyWith(rsiPrev: value));
  }

  void changeRSISMA(double value) {
    emit(state.copyWith(rsiSMA: value));
  }

  void changeRSIPeriod(double value) {
    emit(state.copyWith(rsiPeriod: value));
  }
}
