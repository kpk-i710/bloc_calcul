import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {

  CalculatorBloc() : super(LoadingCalculatorState());
  // Stream<String> retornaString() async* {
  //   yield 'Hola Mundo';
  // }






  @override
  Stream<CalculatorState> mapEventToState(
    CalculatorEvent event,
  ) async* {

    if(event is LoadedCalculator)
    emit(LoadedCalculatorState());

    final state = this.state;
    if (state is LoadedCalculatorState) {
      // Borrar todo


      if ( event is ResetAC ) {
        yield* this._resetAC();

      // Agregar números
      } else if ( event is AddNumber ) {
        yield state.copyWith(

          myList: [...state.myList ,state.mathResult],
          mathResult: (state.mathResult == '0')
                        ? event.number
                        : state.mathResult + event.number,

        );
        print(state.myList);

      // Cambiar signo de + o -
      } else if ( event is ChangeNegativePositive ) {
        yield state.copyWith(
          mathResult:  state.mathResult.contains('-') 
                        ? state.mathResult.replaceFirst('-', '')
                        : '-' + state.mathResult
        );

        // Borrar último digito
      } else if ( event is DeleteLastEntry ) {
        yield state.copyWith(
          mathResult: state.mathResult.length > 1
                      ? state.mathResult.substring(0, state.mathResult.length - 1)
                      : '0'
        );

        // Agregar operación
      } else if ( event is OperationEntry ) {
        yield state.copyWith(
          firstNumber: state.mathResult,
          mathResult: '0',
          operation: event.operation,
          secondNumber: '0'
        );

        // Calcular resultado
      } else if ( event is CalculateResult ) {
        yield* _calculateResult();
      }}
  }


  Stream<LoadedCalculatorState> _resetAC() async* {
    yield LoadedCalculatorState(
          firstNumber: '0',
          mathResult: '0',
          secondNumber: '0',
          operation: '+'
        );
  }

  Stream<CalculatorState> _calculateResult() async* {
    final state = this.state;
    if (state is LoadedCalculatorState) {
    final double num1 = double.parse( state.firstNumber );
    final double num2 = double.parse( state.mathResult );

    switch( state.operation ) {

      case '+':
        yield state.copyWith(
          secondNumber: state.mathResult,
          mathResult: '${num1 + num2}'
        );
      break;


      default:
        yield state;
    }
  }}

}
