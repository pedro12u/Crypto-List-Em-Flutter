import 'package:flutter/material.dart';
import 'package:cripto_moedas_app/domain/entities/crypto_currency.dart';
import 'package:cripto_moedas_app/domain/repositories/crypto_repository.dart';

enum ViewState { idle, loading, success, error }

class CryptoListViewModel extends ChangeNotifier {
  final CryptoRepository cryptoRepository;

  CryptoListViewModel({required this.cryptoRepository}) {
    fetchCryptoCurrencies();
  }

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  List<CryptoCurrency> _cryptos = [];
  List<CryptoCurrency> get cryptos => _cryptos;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCryptoCurrencies({String symbols = ''}) async {
    _state = ViewState.loading;
    notifyListeners();

    final result = await cryptoRepository.getCryptoCurrencies(symbols);

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _state = ViewState.error;
      },
      (data) {
        _cryptos = data;
        _state = ViewState.success;
      },
    );
    notifyListeners();
  }
}
