import 'dart:convert';
import 'package:habit_app/model/quote_model.dart';
import 'package:http/http.dart' as http;

class QuoteRepository {
  Future<QuoteModel> fetchDailyQuote() async {
    final response =
        await http.get(Uri.parse('https://api.quotable.io/random'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return QuoteModel.fromJson(data);
    } else {
      throw Exception('Failed to load quote');
    }
  }
}
