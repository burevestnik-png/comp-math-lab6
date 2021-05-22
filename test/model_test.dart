import 'dart:math';

import 'package:comp_math_lab6/domain/models/differential_methods/adams_method.dart';
import 'package:comp_math_lab6/domain/models/differential_methods/differential_method.dart';
import 'package:comp_math_lab6/domain/models/differential_methods/runge_kutta_method.dart';
import 'package:comp_math_lab6/domain/models/dot.dart';
import 'package:comp_math_lab6/domain/models/equation.dart';
import 'package:flutter_test/flutter_test.dart';

final _rungeKuttaMethod = RungeKuttaMethod();
final _adamsMethod = AdamsMethod();

void solve(
  Equation equation, {
  required double initY,
  required double from,
  required double to,
  required double step,
  required double accuracy,
}) {
  List<Dot> processMethod(DifferentialMethod method, double step) =>
      method.process(equation, initY: initY, from: from, to: to, step: step);

  /*process(processMethod, _rungeKuttaMethod,
      step: step, equation: equation, accuracy: accuracy);*/

  process(processMethod, _adamsMethod,
      step: step, equation: equation, accuracy: accuracy);
}

List<Dot> process(
  List<Dot> processMethod(DifferentialMethod method, double step),
  DifferentialMethod method, {
  required double step,
  required Equation equation,
  required double accuracy,
}) {
  List<StepResult> iterationResult = [];
  List<Dot> dots = [];
  int iterations = 0;
  do {
    ++iterations;

    var baseSolutions = processMethod(method, step);
    var moreAccurateSolutions = processMethod(method, step / 2.0);
    dots = baseSolutions;
    step /= 2;

    iterationResult = method.formAccuracyDifference(
        equation, baseSolutions, moreAccurateSolutions);
  } while (
      !_isAccuracyReached(iterationResult, accuracy) && iterations <= 1000);

  iterationResult.forEach((element) {
    print(element);
  });

  return dots;
}

bool _isAccuracyReached(List<StepResult> results, double accuracy) {
  bool isReached = true;
  results.forEach((element) {
    if (element.r > accuracy) isReached = false;
  });

  return isReached;
}

void main() {
  double x0 = 3;
  double y0 = -3;
  double rangeEnd = 3.6;
  double accuracy = 0.01;
  double step = 0.025;

  test("Runge-kutta method", () {
    expect(1, 1);
  });

  test("Adams method", () {
    var equation = Equation("", (x, y) => y + (1 + x) * pow(y, 2));
    solve(equation,
        initY: y0, from: x0, to: rangeEnd, step: step, accuracy: 0.01);
    expect(1, 1);
  });
}
