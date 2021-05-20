import 'package:comp_math_lab6/domain/models/dot.dart';
import 'package:comp_math_lab6/domain/models/equation.dart';

abstract class DifferentialMethod {
  List<Dot> process(
    Equation equation, {
    required double initY,
    required double from,
    required double to,
    required double step,
  });

  int getIterationsAmount(double from, double to, double step) =>
      (to - from) ~/ step;
}
