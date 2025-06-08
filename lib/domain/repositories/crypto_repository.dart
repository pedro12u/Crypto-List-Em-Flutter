import 'package:cripto_moedas_app/core/failure/failure.dart';
import 'package:cripto_moedas_app/domain/entities/crypto_currency.dart';

abstract class Either<L, R> {
  const Either();
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);
}

class Left<L, R> extends Either<L, R> {
  final L _l;
  const Left(this._l);
  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifLeft(_l);
}

class Right<L, R> extends Either<L, R> {
  final R _r;
  const Right(this._r);
  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifRight(_r);
}

abstract class CryptoRepository {
  Future<Either<Failure, List<CryptoCurrency>>> getCryptoCurrencies(
      String symbols);
}
