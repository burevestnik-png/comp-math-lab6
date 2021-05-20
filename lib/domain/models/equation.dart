import 'package:uuid/uuid.dart';

class Equation {
  final String id;
  final String value;
  final double Function(double, double) calc;

  Equation(this.value, this.calc) : id = Uuid().v4();

  @override
  String toString() => value;
}
