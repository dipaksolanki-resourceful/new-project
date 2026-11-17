import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState());

  void increment() {
    emit(CounterState(count: state.count + 1));
  }

  void decrement() {
    emit(CounterState(count: state.count - 1));
  }

  void reset() {
    emit(CounterState());
  }
}
