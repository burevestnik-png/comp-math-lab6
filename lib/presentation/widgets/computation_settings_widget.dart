import 'package:comp_math_lab6/domain/controllers/computation_settings_controller.dart';
import 'package:comp_math_lab6/presentation/widgets/option_dropdown_widget.dart';
import 'package:comp_math_lab6/presentation/widgets/option_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/models/differential_methods/differential_method.dart';
import 'option_dropdown_widget.dart';

class ComputationSettings extends GetView<ComputationSettingsController> {
  space([double height = 10.0]) => SizedBox(height: height);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        space(),
        OptionDropdown(
          text: "Choose equation:",
          items: controller.equations,
          obs: controller.currentEquation,
          onChange: controller.onCurrentEquationChange,
        ),
        space(15),
        OptionTextField(
          content: "x0:",
          controller: controller.x0Controller,
          onChange: (String value) => controller.onDoubleFieldChange(
            value,
            obs: controller.x0,
          ),
        ),
        space(),
        OptionTextField(
          content: "y0:",
          controller: controller.y0Controller,
          onChange: (String value) => controller.onDoubleFieldChange(
            value,
            obs: controller.y0,
          ),
        ),
        space(),
        OptionTextField(
          content: "End of range:",
          controller: controller.rangeEndController,
          onChange: (String value) => controller.onDoubleFieldChange(
            value,
            obs: controller.rangeEnd,
          ),
        ),
        space(),
        OptionTextField(
          content: "Accuracy:",
          controller: controller.accuracyController,
          onChange: (String value) => controller.onDoubleFieldChange(
            value,
            obs: controller.accuracy,
          ),
        ),
        space(),
        OptionTextField(
          content: "Step:",
          controller: controller.stepController,
          onChange: (String value) => controller.onDoubleFieldChange(
            value,
            obs: controller.step,
          ),
        ),
        OptionDropdown(
          text: "Choose type:",
          items: MethodType.values,
          obs: controller.currentMethod,
          onChange: controller.onCurrentMethodTypeChange,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: controller.onComputeAction,
                child: Text("Compute"),
              ),
              SizedBox(width: 30),
              ElevatedButton(
                onPressed: controller.reset,
                child: Text("Reset"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
