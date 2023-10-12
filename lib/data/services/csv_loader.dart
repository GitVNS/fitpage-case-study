import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class CSVLoader {
  static Future<List<List<dynamic>>> loadData() async {
    final myData = await rootBundle.loadString("assets/bullish.csv");
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(myData);
    return csvTable;
  }
}
