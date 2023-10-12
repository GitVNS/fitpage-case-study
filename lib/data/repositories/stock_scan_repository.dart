import 'dart:convert';

import 'package:stock_market_scanner/data/models/stock_scan_response.dart';
import 'package:http/http.dart' as http;

class StockScanRepository {
  static const String baseURL = 'coding-assignment.bombayrunning.com';

  Future<List<StockScanResponse>?> getData() async {
    var url = Uri.http(baseURL, 'data.json');
    try {
      var response = await http.get(url);
      List<StockScanResponse> stockScanResponse = [];
      for (var scanResponse in jsonDecode(response.body)) {
        stockScanResponse.add(StockScanResponse.fromJson(scanResponse));
      }
      return stockScanResponse;
    } catch (e) {
      throw Exception(e);
    }
  }
}
