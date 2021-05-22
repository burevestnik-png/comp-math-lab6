import 'package:get/get.dart';

import '../models/differential_methods/differential_method.dart';

class TableResultsController extends GetxController {
  final results = <StepResult>[].obs;
  var currentStep = 0.1.obs;

  void addResult(StepResult result) => results.add(result);

  void addResults(Iterable<StepResult> results) => this.results.addAll(results);

  void clear() => results.clear();
}
