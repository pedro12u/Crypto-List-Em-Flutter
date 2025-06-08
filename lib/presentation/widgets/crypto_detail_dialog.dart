import 'package:flutter/material.dart';
import 'package:cripto_moedas_app/domain/entities/crypto_currency.dart';
import 'package:cripto_moedas_app/utils/currency_formatter.dart';

void showCryptoDetailDialog(BuildContext context, CryptoCurrency crypto) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          'Detalhes de ${crypto.name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              _buildDetailRow('Símbolo:', crypto.symbol),
              _buildDetailRow('Nome:', crypto.name),
              _buildDetailRow(
                  'Preço USD:', CurrencyFormatter.formatUSD(crypto.priceUSD)),
              _buildDetailRow(
                  'Preço BRL:', CurrencyFormatter.formatBRL(crypto.priceBRL)),
              _buildDetailRow('Adicionada em:',
                  CurrencyFormatter.formatDate(crypto.dateAdded)),
              _buildDetailRow(
                'Variação 24h (USD):',
                '${crypto.percentChange24hUSD.toStringAsFixed(2)}%',
                valueColor:
                    crypto.percentChange24hUSD >= 0 ? Colors.green : Colors.red,
              ),
              _buildDetailRow(
                'Variação 24h (BRL):',
                '${crypto.percentChange24hBRL.toStringAsFixed(2)}%',
                valueColor:
                    crypto.percentChange24hBRL >= 0 ? Colors.green : Colors.red,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Fechar', style: TextStyle(fontSize: 16)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 15, color: valueColor),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}
