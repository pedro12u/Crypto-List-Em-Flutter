import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cripto_moedas_app/core/config/app_constants.dart';
import 'package:cripto_moedas_app/core/failure/failure.dart';
import 'package:cripto_moedas_app/data/models/crypto_currency_model.dart';

abstract class CoinMarketCapRemoteDataSource {
  Future<List<CryptoCurrencyModel>> getCryptoCurrencyQuotes(String symbols);
}

class CoinMarketCapRemoteDataSourceImpl
    implements CoinMarketCapRemoteDataSource {
  final http.Client client;

  CoinMarketCapRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CryptoCurrencyModel>> getCryptoCurrencyQuotes(
      String symbols) async {
    final String symbolsToFetch =
        symbols.isEmpty ? AppConstants.defaultSymbols : symbols;

    try {
      final quotesUSD = await _fetchQuotes(symbolsToFetch, 'USD');
      final quotesBRL = await _fetchQuotes(symbolsToFetch, 'BRL');

      final List<CryptoCurrencyModel> result = [];

      for (var entry in quotesUSD.entries) {
        final String symbol = entry.key;
        final CryptoCurrencyModel usdModel = entry.value;
        final CryptoCurrencyModel? brlModel = quotesBRL[symbol];

        if (brlModel != null) {
          usdModel.priceBRL = brlModel.priceBRL;
          usdModel.percentChange24hBRL = brlModel.percentChange24hBRL;
        }

        result.add(usdModel);
      }

      return result;
    } catch (e) {
      if (e is Failure) rethrow;
      print('Erro na chamada da API: $e');
      throw NetworkFailure('Falha na comunicação com o servidor: $e');
    }
  }

  Future<Map<String, CryptoCurrencyModel>> _fetchQuotes(
      String symbols, String convertTo) async {
    final uri = Uri.parse(
      '${AppConstants.baseUrl}${AppConstants.quotesLatestEndpoint}?symbol=$symbols&convert=$convertTo',
    );

    final response = await client.get(
      uri,
      headers: {
        'Accepts': 'application/json',
        'X-CMC_PRO_API_KEY': AppConstants.apiKey,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['data'];

      if (data is! Map<String, dynamic>) {
        throw ServerFailure('Formato inesperado da resposta da API.');
      }

      final result = <String, CryptoCurrencyModel>{};

      data.forEach((symbol, value) {
        if (value is Map<String, dynamic>) {
          result[symbol] = CryptoCurrencyModel.fromJson(symbol, value);
        }
      });

      return result;
    } else {
      final jsonResponse = json.decode(response.body);
      final errorMessage = jsonResponse['status']?['error_message'] ??
          'Erro desconhecido da API';
      throw ServerFailure(
          'Erro da API: ${response.statusCode} - $errorMessage');
    }
  }
}
