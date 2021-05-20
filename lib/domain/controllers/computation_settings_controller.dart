import 'dart:math';

import 'package:comp_math_lab6/domain/controllers/computation_controller.dart';
import 'package:comp_math_lab6/domain/models/equation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComputationSettingsController extends GetxController {
  final _computationController = Get.find<ComputationController>();

  var equations = [
    Equation("y' = y + (x + 1) * y^2", (x, y) => y + (x + 1) * pow(y, 2)),
    Equation("y' = e^(2x) + y", (x, y) => pow(e, 2 * x) + y),
  ];

  late Rx<Equation> currentEquation;
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
    _restoreFieldControllers();
  }

  void onCurrentEquationChange(Equation equation) =>
      currentEquation.value = equation;

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
      print(
          '${currentEquation.value} ${x0.value} ${y0.value} ${rangeEnd.value} ${accuracy.value} ${step.value}');
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
