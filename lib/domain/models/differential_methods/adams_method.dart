import 'dart:math';

import 'package:comp_math_lab6/domain/models/differential_methods/differential_method.dart';
import 'package:comp_math_lab6/domain/models/differential_methods/runge_kutta_method.dart';
import 'package:comp_math_lab6/domain/models/dot.dart';
import 'package:comp_math_lab6/domain/models/equation.dart';

class AdamsMethod extends DifferentialMethod {
  static const int ACCURACY_ORDER = 4;

  @override
  List<Dot> process(
    Equation equation, {
    required double initY,
    required double from,
    required double to,
    required double step,
  }) {
    int iterations = getIterationsAmount(from, to, step);
    List<Dot> solutions = List.from(RungeKuttaMethod().process(
      equation,
      initY: initY,
      from: from,
      to: from + 3 * step,
      step: step,
    ));

    for (var i = 3; i < iterations; ++i) {
      var fi0 = equation.calc(solutions[i].x, solutions[i].y);
      var fi1 = equation.calc(solutions[i - 1].x, solutions[i - 1].y);
      var fi2 = equation.calc(solutions[i - 2].x, solutions[i - 2].y);
      var fi3 = equation.calc(solutions[i - 3].x, solutions[i - 3].y);

      var dfi = fi0 - fi1;
      var d2fi = fi0 - 2 * fi1 + fi2;
      var d3fi = fi0 - 3 * fi1 + 3 * fi2 - fi3;

      var yi = solutions[i].y;
      var yNext = yi +
          step * fi0 +
          pow(step, 2) * dfi / 2.0 +
          5 * pow(step, 3) * d2fi / 12.0 +
          3 * pow(step, 4) * d3fi / 8.0;

      solutions.add(Dot(solutions[i].x + step, yNext));
    }

    return solutions;
  }
}
