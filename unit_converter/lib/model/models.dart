
class Unit {
  final String key;
  final String name;

  Unit(this.key, this.name);
}

class Brain {
  Map<String, double> formulas;
  List<Unit> units;

  void initUnits() {
    formulas = {};
    formulas["cm-m"] = 0.01;
    formulas["cm-km"] = 0.00001;
    formulas["m-cm"] = 100;
    formulas["m-km"] = 0.001;
    formulas["km-cm"] = 100000;
    formulas["km-m"] = 1000;

    units = [
      Unit("cm", "Centimeter"),
      Unit("m", "Meter"),
      Unit("km", "Kilometer")
    ];
  }
  double calculate(Unit from, Unit to, double value) {
    var multiplier = formulas["${from.key}-${to.key}"] ?? 1;
    return multiplier * value;
  }

}
