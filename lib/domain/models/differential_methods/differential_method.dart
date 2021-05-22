import 'dart:math';

import 'package:comp_math_lab6/domain/models/dot.dart';
import 'package:comp_math_lab6/domain/models/equation.dart';

class StepResult {
  final int iteration;
  final double x;
  final double y;
  final double yDerivative;
  final double r;

  StepResult(this.iteration, this.x, this.y, this.yDerivative, this.r);

  @override
  String toString() =>
      'StepResult{iteration: $iteration, x: $x, y: $y, yDerivative: $yDerivative, r: $r}';
}

abstract class DifferentialMethod {
  List<Dot> process(
    Equation equation, {
    required double initY,
    required double from,
    required double to,
    required double step,
  });

  List<StepResult> formAccuracyDifference(
    Equation equation,
    List<Dot> baseDots,
    List<Dot> moreAccurateDots, {
    int accuracyOrder = 4,
  }) {
    List<StepResult> results = [];

    for (var i = 0; i < baseDots.length; ++i) {
      results.add(StepResult(
        i,
        baseDots[i].x,
        baseDots[i].y,
        equation.calc(baseDots[i].x, baseDots[i].y),
        ((baseDots[i].y - moreAccurateDots[i * 2].y) /
                DifferentialMethod.getAccuracyOrderFactor(accuracyOrder))
            .abs(),
      ));
    }

    return results;
  }

  int getIterationsAmount(double from, double to, double step) {
    return ((to - from) / step).round();
  }

  static getAccuracyOrderFactor(int order) => pow(2, order) - 1;
}
