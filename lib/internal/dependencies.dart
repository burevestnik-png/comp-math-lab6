import 'package:comp_math_lab6/domain/controllers/computation_controller.dart';
import 'package:comp_math_lab6/domain/controllers/computation_settings_controller.dart';
import 'package:comp_math_lab6/domain/controllers/drawing_controller.dart';
import 'package:comp_math_lab6/domain/controllers/table_results_controller.dart';
import 'package:get/get.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<TableResultsController>(TableResultsController());
    Get.put<DrawingController>(DrawingController());
    Get.put<ComputationController>(ComputationController());
    Get.put<ComputationSettingsController>(ComputationSettingsController());
  }
}
