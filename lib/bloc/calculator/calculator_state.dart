part of 'calculator_bloc.dart';

abstract class CalculatorState{}


class LoadingCalculatorState extends CalculatorState{}

class LoadedCalculatorState  extends CalculatorState {
  
  final String mathResult;
  final String firstNumber;
  final String secondNumber;
  final String operation;
  final List<String> myList;

  LoadedCalculatorState({
    this.mathResult = '30', 
    this.firstNumber = '10', 
    this.secondNumber = '20', 
    this.operation = '+',
    this.myList = const []
  });

  LoadedCalculatorState copyWith({
    String? mathResult,
    String? firstNumber,
    String? secondNumber,
    List<String> ? myList,
    String? operation,
  }) => LoadedCalculatorState(
    mathResult  : mathResult ?? this.mathResult,
    myList  : myList ?? this.myList,
    firstNumber : firstNumber ?? this.firstNumber,
    secondNumber: secondNumber ?? this.secondNumber, 
    operation   : operation ?? this.operation, 
  );


}

