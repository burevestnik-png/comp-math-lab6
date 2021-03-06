import 'dart:math';

import 'package:comp_math_lab6/domain/controllers/computation_controller.dart';
import 'package:comp_math_lab6/domain/models/equation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/differential_methods/differential_method.dart';

class ComputationSettingsController extends GetxController {
  final _computationController = Get.find<ComputationController>();

  var equations = [
    Equation("y' = y + (x + 1) * y^2", (x, y) => y + (x + 1) * pow(y, 2)),
    Equation("y' = e^(2x) + y", (x, y) => pow(e, 2 * x) + y),
    Equation("y' = x^2 - 2 * y", (x, y) => pow(x, 2) - y * 2),
  ];

  late Rx<Equation> currentEquation;
  late Rx<MethodType> currentMethod;
  var x0 = 1.0.obs;
  var y0 = (-1.0).obs;
  var rangeEnd = 1.5.obs;
  var accuracy = 0.01.obs;
  var step = 0.1.obs;

  final x0Controller = TextEditingController();
  final y0Controller = TextEditingController();
  final rangeEndController = TextEditingController();
  final accuracyController = TextEditingController();
  final stepController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    currentEquation = equations[0].obs;
    currentMethod = MethodType.RUNGE_KUTTA.obs;
    _restoreFieldControllers();
  }

  void onCurrentEquationChange(Equation equation) =>
      currentEquation.value = equation;

  void onCurrentMethodTypeChange(MethodType type) => currentMethod.value = type;

  void onDoubleFieldChange(
    String value, {
    required RxDouble obs,
  }) {
    var parsedValue = double.tryParse(value);
    if (parsedValue == null) return;

    obs.value = parsedValue;
  }

  bool isBordersCorrect() => x0.value < rangeEnd.value;

  bool isStepCorrect() =>
      step.value > 0 && step.value <= (rangeEnd.value - x0.value);

  bool isAccuracyCorrect() => accuracy.value > 0;

  void onComputeAction() {
    if (isBordersCorrect() && isStepCorrect() && isAccuracyCorrect()) {
      _computationController.solve(
        currentEquation.value,
        currentMethod.value,
        initY: y0.value,
        from: x0.value,
        to: rangeEnd.value,
        step: step.value,
        accuracy: accuracy.value,
      );
    }
  }

  void reset() {
    currentEquation.value = equations.first;
    x0.value = 1.0;
    y0.value = -1.0;
    rangeEnd.value = 1.5;
    accuracy.value = 0.01;
    step.value = 0.1;

    _restoreFieldControllers();
  }

  void _restoreFieldControllers() {
    x0Controller.text = x0.value.toStringAsFixed(1);
    y0Controller.text = y0.value.toStringAsFixed(1);
    rangeEndController.text = rangeEnd.value.toStringAsFixed(1);
    accuracyController.text = accuracy.value.toStringAsFixed(2);
    stepController.text = step.value.toStringAsFixed(1);
  }
}
