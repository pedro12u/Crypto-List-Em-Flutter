import 'package:cripto_moedas_app/domain/entities/crypto_currency.dart';

class CryptoCurrencyModel extends CryptoCurrency {
  @override
  double priceBRL;

  @override
  double percentChange24hBRL;

  CryptoCurrencyModel({
    required String id,
    required String name,
    required String symbol,
    required double priceUSD,
    required this.priceBRL,
    required DateTime dateAdded,
    required double percentChange24hUSD,
    required this.percentChange24hBRL,
  }) : super(
          id: id,
          name: name,
          symbol: symbol,
          priceUSD: priceUSD,
          priceBRL: priceBRL,
          dateAdded: dateAdded,
          percentChange24hUSD: percentChange24hUSD,
          percentChange24hBRL: percentChange24hBRL,
        );

  factory CryptoCurrencyModel.fromJson(
      String symbolKey, Map<String, dynamic> json) {
    final quote = json['quote'];

    final usdData = quote?['USD'];
    final brlData = quote?['BRL'];

    double parseDouble(dynamic value) {
      if (value is int) return value.toDouble();
      if (value is double) return value;
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return CryptoCurrencyModel(
      id: symbolKey,
      name: json['name'] ?? 'Inválido',
      symbol: json['symbol'] ?? symbolKey,
      priceUSD: parseDouble((usdData is Map) ? usdData['price'] : null),
      priceBRL: parseDouble((brlData is Map) ? brlData['price'] : null),
      dateAdded: json['date_added'] != null
          ? DateTime.tryParse(json['date_added']) ?? DateTime.now()
          : DateTime.now(),
      percentChange24hUSD:
          parseDouble((usdData is Map) ? usdData['percent_change_24h'] : null),
      percentChange24hBRL:
          parseDouble((brlData is Map) ? brlData['percent_change_24h'] : null),
    );
  }

  static List<CryptoCurrencyModel> toDomainList(Map<String, dynamic> apiData) {
    if (apiData.isEmpty) return [];

    return apiData.entries.map((entry) {
      final value = entry.value;

      if (value is! Map<String, dynamic>) {
        print('⚠️ Entrada inválida para ${entry.key}: ${value.runtimeType}');
      }

      if (value is Map<String, dynamic>) {
        return CryptoCurrencyModel.fromJson(entry.key, value);
      } else {
        return CryptoCurrencyModel(
          id: entry.key,
          name: 'Inválido',
          symbol: entry.key,
          priceUSD: 0.0,
          priceBRL: 0.0,
          dateAdded: DateTime.now(),
          percentChange24hUSD: 0.0,
          percentChange24hBRL: 0.0,
        );
      }
    }).toList();
  }
}
