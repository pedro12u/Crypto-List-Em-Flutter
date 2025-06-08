import 'package:cripto_moedas_app/core/failure/failure.dart';
import 'package:cripto_moedas_app/data/datasources/coinmarketcap_remote_datasource.dart';
import 'package:cripto_moedas_app/domain/entities/crypto_currency.dart';
import 'package:cripto_moedas_app/domain/repositories/crypto_repository.dart';
// Importe a simulação do Either ou o pacote dartz
// import 'package:dartz/dartz.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final CoinMarketCapRemoteDataSource remoteDataSource;

  CryptoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CryptoCurrency>>> getCryptoCurrencies(
      String symbols) async {
    try {
      // Os modelos da camada de dados (CryptoCurrencyModel) já estendem as entidades de domínio (CryptoCurrency)
      // então a conversão é direta. Se fossem diferentes, aqui ocorreria o mapeamento.
      final List<CryptoCurrency> cryptoCurrencies =
          await remoteDataSource.getCryptoCurrencyQuotes(symbols);
      return Right(cryptoCurrencies);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkFailure catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(
          UnknownFailure('Erro desconhecido ao buscar criptomoedas: $e'));
    }
  }
}
