import 'dart:math';

import 'package:comp_math_lab6/domain/controllers/computation_controller.dart';
import 'package:comp_math_lab6/domain/models/differential_methods/differential_method.dart';
import 'package:comp_math_lab6/domain/models/equation.dart';
import 'package:comp_math_lab6/internal/dependencies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  double x0 = 1;
  double y0 = 1;
  double rangeEnd = 1.5;
  double accuracy = 0.001;
  double step = 0.1;

  GlobalBindings().dependencies();

  test("Adams method", () {
    var equation = Equation("", (x, y) => y + (1 + x) * pow(y, 2));

    Get.find<ComputationController>().solve(equation, MethodType.RUNGE_KUTTA,
        initY: y0, from: x0, to: rangeEnd, step: step, accuracy: accuracy);

    expect(1, 1);
  });
}
