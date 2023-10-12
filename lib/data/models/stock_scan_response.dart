class StockScanResponse {
  int id;
  String name;
  String tag;
  String color;
  List<Criterion> criteria;

  StockScanResponse({
    required this.id,
    required this.name,
    required this.tag,
    required this.color,
    required this.criteria,
  });

  factory StockScanResponse.fromJson(Map<String, dynamic> json) =>
      StockScanResponse(
        id: json["id"],
        name: json["name"],
        tag: json["tag"],
        color: json["color"],
        criteria: List<Criterion>.from(
            json["criteria"].map((x) => Criterion.fromJson(x))),
      );
}

class Criterion {
  String type;
  String text;
  Variable? variable;

  Criterion({
    required this.type,
    required this.text,
    this.variable,
  });

  factory Criterion.fromJson(Map<String, dynamic> json) => Criterion(
        type: json["type"],
        text: json["text"],
        variable: json["variable"] == null
            ? null
            : Variable.fromJson(json["variable"]),
      );
}

class Variable {
  Dollar? the1;
  Dollar? the2;
  Dollar? the3;
  Dollar? the4;

  Variable({
    this.the1,
    this.the2,
    this.the3,
    this.the4,
  });

  factory Variable.fromJson(Map<String, dynamic> json) => Variable(
        the1: json["\$1"] == null ? null : Dollar.fromJson(json["\$1"]),
        the2: json["\$2"] == null ? null : Dollar.fromJson(json["\$2"]),
        the3: json["\$3"] == null ? null : Dollar.fromJson(json["\$3"]),
        the4: json["\$4"] == null ? null : Dollar.fromJson(json["\$4"]),
      );
}

class Dollar {
  String type;
  List<double>? values;
  String? studyType;
  String? parameterName;
  int? minValue;
  int? maxValue;
  int? defaultValue;

  Dollar({
    required this.type,
    required this.values,
    this.studyType,
    this.parameterName,
    this.minValue,
    this.maxValue,
    this.defaultValue,
  });

  factory Dollar.fromJson(Map<String, dynamic> json) => Dollar(
        type: json["type"],
        values: json["values"] == null
            ? []
            : List<double>.from(json["values"].map((x) => x?.toDouble())),
        studyType: json["study_type"],
        parameterName: json["parameter_name"],
        minValue: json["min_value"],
        maxValue: json["max_value"],
        defaultValue: json["default_value"],
      );
}
