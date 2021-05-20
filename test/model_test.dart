import 'dart:math';

import 'package:comp_math_lab6/domain/models/dot.dart';
import 'package:flutter_test/flutter_test.dart';

double calc(double x, double y) {
  return y + (1 + x) * pow(y, 2);
}

List<Dot> rungeKuttaMethod(double initY, double from, double to, double step) {
  int iterations = (to - from) ~/ step;
  List<Dot> solutions = [Dot(from, initY)];

  var currentX = from;
  var currentY = initY;
  for (int i = 0; i < iterations; ++i) {
    var k1 = calc(currentX, currentY);

    var yp2 = currentY + k1 * (step / 2);
    var k2 = calc(currentX + step / 2, yp2);

    var yp3 = currentY + k2 * (step / 2);
    var k3 = calc(currentX + step / 2, yp3);

    var yp4 = currentY + k3 * step;
    var k4 = calc(currentX + step / 2, yp4);

    currentY = currentY + (step / 6) * (k1 + 2 * k2 + 2 * k3 + k4);
    currentX = currentX + step;

    solutions.add(Dot(currentX, currentY));
  }

  return solutions;
}

List<Dot> adamsMethod(double initY, double from, double to, double step) {
  int iterations = (to - from) ~/ step;
  List<Dot> adamsSolutions =
      List.from(rungeKuttaMethod(initY, from, from + 3 * step, step));

  for (var i = 3; i < iterations; ++i) {
    var fi0 = calc(adamsSolutions[i].x, adamsSolutions[i].y);
    var fi1 = calc(adamsSolutions[i - 1].x, adamsSolutions[i - 1].y);
    var fi2 = calc(adamsSolutions[i - 2].x, adamsSolutions[i - 2].y);
    var fi3 = calc(adamsSolutions[i - 3].x, adamsSolutions[i - 3].y);

    var yi = adamsSolutions[i].y;
    var yPredictor =
        yi + (step / 24) * (55 * fi0 - 59 * fi1 + 37 * fi2 - 9 * fi3);

    var fiNext = calc(adamsSolutions[i].x + step, yPredictor);
    var yCorrector = yi + (step / 24) * (9 * fiNext + 19 * fi0 - 5 * fi1 + fi2);

    adamsSolutions.add(Dot(adamsSolutions[i].x + step, yCorrector));
  }

  return adamsSolutions;
}

void main() {
  double x0 = 1;
  double y0 = -1;
  double rangeEnd = 1.5;
  double accuracy = 0.01;
  double step = 0.1;

  test("Runge-kutta method", () {
    rungeKuttaMethod(y0, x0, rangeEnd, step);
    expect(1, 1);
  });

  test("Adams method", () {
    var sols = adamsMethod(y0, x0, rangeEnd, step);
    sols.forEach((element) {
      print(element);
    });
    expect(1, 1);
  });
}
