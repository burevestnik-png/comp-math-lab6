import 'package:comp_math_lab6/domain/models/differential_methods/differential_method.dart';
import 'package:comp_math_lab6/domain/models/differential_methods/runge_kutta_method.dart';
import 'package:comp_math_lab6/domain/models/dot.dart';
import 'package:comp_math_lab6/domain/models/equation.dart';

class AdamsMethod extends DifferentialMethod {
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

      var yi = solutions[i].y;
      var yPredictor =
          yi + (step / 24) * (55 * fi0 - 59 * fi1 + 37 * fi2 - 9 * fi3);

      var fiNext = equation.calc(solutions[i].x + step, yPredictor);
      var yCorrector =
          yi + (step / 24) * (9 * fiNext + 19 * fi0 - 5 * fi1 + fi2);

      solutions.add(Dot(solutions[i].x + step, yCorrector));
    }

    return solutions;
  }
}
