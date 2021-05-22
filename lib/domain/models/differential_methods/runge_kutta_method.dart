import 'package:comp_math_lab6/domain/models/differential_methods/differential_method.dart';
import 'package:comp_math_lab6/domain/models/dot.dart';
import 'package:comp_math_lab6/domain/models/equation.dart';

class RungeKuttaMethod extends DifferentialMethod {
  static const int ACCURACY_ORDER = 4;

  @override
  List<Dot> process(
    Equation equation, {
    required double initY,
    required double from,
    required double to,
    required double step,
  }) {
    var iterations = getIterationsAmount(from, to, step);
    List<Dot> solutions = [Dot(from, initY)];

    var currentX = from;
    var currentY = initY;
    for (int i = 0; i < iterations; ++i) {
      var k1 = step * equation.calc(currentX, currentY);
      var k2 = step * equation.calc(currentX + step / 2, currentY + k1 / 2);
      var k3 = step * equation.calc(currentX + step / 2, currentY + k2 / 2);
      var k4 = step * equation.calc(currentX + step, currentY + k3);

      currentY = currentY + (1 / 6) * (k1 + 2 * k2 + 2 * k3 + k4);
      currentX = currentX + step;

      solutions.add(Dot(currentX, currentY));
    }

    return solutions;
  }
}
