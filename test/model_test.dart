import 'dart:math';

import 'package:comp_math_lab6/domain/models/dot.dart';
import 'package:flutter_test/flutter_test.dart';

double calc(double x, double y) {
  return y + (1 + x) * pow(y, 2);
}

void rungeKuttaMethod(double initY, double from, double to, double step) {
  int iterations = (from - to) ~/ step;
  List<Dot> solutions = [Dot(initY, from)];

  var currentX = from;
  var currentY = initY;
  for (int i = 0; i < iterations; ++i) {
    var k1 = calc(currentX, currentY);

    var yp2 = currentY + k1 * (step / 2);
    var k2 = calc(currentX + step / 2, yp2);

    var yp3 = currentY + k2 * (step / 2);
    var k3 = calc(currentX + step / 2, yp3);

    var yp4 = currentY + k3 * step;
  }
}

void main() {
  double x0 = 1;
  double y0 = -1;
  double rangeEnd = 1.5;
  double accuracy = 0.01;
  double step = 0.1;

  test("Runge-kutta method", () {
    expect(1, 1);
  });
}
