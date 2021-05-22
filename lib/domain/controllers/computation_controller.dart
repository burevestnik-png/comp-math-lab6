import 'package:comp_math_lab6/domain/controllers/drawing_controller.dart';
import 'package:comp_math_lab6/domain/controllers/table_results_controller.dart';
import 'package:comp_math_lab6/domain/models/differential_methods/adams_method.dart';
import 'package:comp_math_lab6/domain/models/differential_methods/differential_method.dart';
import 'package:comp_math_lab6/domain/models/differential_methods/runge_kutta_method.dart';
import 'package:comp_math_lab6/domain/models/dot.dart';
import 'package:comp_math_lab6/domain/models/equation.dart';
import 'package:get/get.dart';

class ComputationController extends GetxController {
  final _drawingController = Get.find<DrawingController>();
  final _resultsController = Get.find<TableResultsController>();

  final _rungeKuttaMethod = RungeKuttaMethod();
  final _adamsMethod = AdamsMethod();

  var _lineId = 0;

  void solve(
    Equation equation,
    MethodType type, {
    required double initY,
    required double from,
    required double to,
    required double step,
    required double accuracy,
  }) {
    List<Dot> processMethod(DifferentialMethod method, double step) =>
        method.process(equation, initY: initY, from: from, to: to, step: step);

    _resultsController.clear();
    var dots = type == MethodType.RUNGE_KUTTA
        ? process(processMethod, _rungeKuttaMethod,
            step: step, equation: equation, accuracy: accuracy)
        : process(processMethod, _adamsMethod,
            step: step, equation: equation, accuracy: accuracy);

    _lineId =
        _drawingController.drawLineByDots(dots, id: _lineId, isCurved: false);
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

      if (isInfinityAnswer(iterationResult)) {
        print('Unreachable answer!');
        return [];
      }
    } while (
        !_isAccuracyReached(iterationResult, accuracy) && iterations <= 1000);

    _resultsController.addResults(iterationResult);
    _resultsController.currentStep.value = step * 2;
    return dots;
  }

  bool isInfinityAnswer(List<StepResult> results) {
    bool answer = false;

    for (var value in results) {
      if (value.y.isNaN ||
          value.y.isInfinite ||
          value.yDerivative.isNaN ||
          value.yDerivative.isInfinite ||
          value.r.isNaN ||
          value.r.isInfinite) {
        return true;
      }
    }

    return answer;
  }

  bool _isAccuracyReached(List<StepResult> results, double accuracy) {
    bool isReached = true;
    results.forEach((element) {
      if (element.r > accuracy) isReached = false;
    });

    return isReached;
  }
}
