class QuoteModel {
  final String text;
  final String Author;

  QuoteModel({required this.text, required this.Author});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(text: json['text'], Author: json['Author']);
  }
}
