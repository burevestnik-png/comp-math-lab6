import 'package:comp_math_lab6/domain/controllers/drawing_controller.dart';
import 'package:comp_math_lab6/domain/controllers/log_controller.dart';
import 'package:get/get.dart';

class ComputationController extends GetxController {
  final _logger = Get.find<LogController>();
  final _drawingController = Get.find<DrawingController>();
}
