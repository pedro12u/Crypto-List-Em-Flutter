class CryptoCurrency {
  final String id;
  final String name;
  final String symbol;
  final double priceUSD;
  final double priceBRL;
  final DateTime dateAdded;
  final double percentChange24hUSD;
  final double percentChange24hBRL;

  CryptoCurrency({
    required this.id,
    required this.name,
    required this.symbol,
    required this.priceUSD,
    required this.priceBRL,
    required this.dateAdded,
    required this.percentChange24hUSD,
    required this.percentChange24hBRL,
  });
}
