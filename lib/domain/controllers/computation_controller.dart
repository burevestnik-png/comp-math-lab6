import 'package:comp_math_lab6/domain/controllers/drawing_controller.dart';
import 'package:comp_math_lab6/domain/controllers/log_controller.dart';
import 'package:comp_math_lab6/domain/models/differential_methods/adams_method.dart';
import 'package:comp_math_lab6/domain/models/differential_methods/differential_method.dart';
import 'package:comp_math_lab6/domain/models/differential_methods/runge_kutta_method.dart';
import 'package:comp_math_lab6/domain/models/dot.dart';
import 'package:comp_math_lab6/domain/models/equation.dart';
import 'package:get/get.dart';

class ComputationController extends GetxController {
  final _logger = Get.find<LogController>();
  final _drawingController = Get.find<DrawingController>();

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

    process(processMethod, _rungeKuttaMethod,
        step: step, equation: equation, accuracy: accuracy);

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

    return dots;
  }

  bool _isAccuracyReached(List<StepResult> results, double accuracy) {
    bool isReached = true;
    results.forEach((element) {
      if (element.r > accuracy) isReached = false;
    });

    return isReached;
  }
}
