import 'package:flutter/material.dart';
import 'package:cripto_moedas_app/domain/entities/crypto_currency.dart';
import 'package:cripto_moedas_app/utils/currency_formatter.dart';

class CryptoListItem extends StatelessWidget {
  final CryptoCurrency crypto;
  final VoidCallback onTap;

  const CryptoListItem({
    super.key,
    required this.crypto,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            crypto.symbol.isNotEmpty ? crypto.symbol[0] : '?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        title: Text(
          '${crypto.name} (${crypto.symbol})',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'USD: ${CurrencyFormatter.formatUSD(crypto.priceUSD)}',
              style: TextStyle(color: Colors.green[700], fontSize: 14),
            ),
            Text(
              'BRL: ${CurrencyFormatter.formatBRL(crypto.priceBRL)}',
              style: TextStyle(color: Colors.blue[700], fontSize: 14),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
