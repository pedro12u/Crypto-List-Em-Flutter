import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cripto_moedas_app/presentation/viewmodels/crypto_list_viewmodel.dart';
import 'package:cripto_moedas_app/presentation/widgets/crypto_list_item.dart';
import 'package:cripto_moedas_app/presentation/widgets/crypto_detail_dialog.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final symbols = _searchController.text.trim().toUpperCase();
    Provider.of<CryptoListViewModel>(context, listen: false)
        .fetchCryptoCurrencies(symbols: symbols);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criptomoedas'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                        hintText: 'Ex: BTC,ETH,SOL (padrão se vazio)',
                        labelText: 'Pesquisar Símbolos',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            Provider.of<CryptoListViewModel>(context,
                                    listen: false)
                                .fetchCryptoCurrencies();
                          },
                        )),
                    onSubmitted: (_) => _performSearch(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  icon: const Icon(Icons.search),
                  label: const Text('Buscar'),
                  onPressed: _performSearch,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<CryptoListViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.state == ViewState.loading &&
                    viewModel.cryptos.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (viewModel.state == ViewState.error) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline,
                              color: Colors.red[700], size: 50),
                          const SizedBox(height: 10),
                          Text(
                            'Erro ao carregar dados: ${viewModel.errorMessage}',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.red[700], fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.refresh),
                            label: const Text('Tentar Novamente'),
                            onPressed: () => viewModel.fetchCryptoCurrencies(
                                symbols: _searchController.text.trim()),
                          )
                        ],
                      ),
                    ),
                  );
                }
                if (viewModel.state == ViewState.success &&
                    viewModel.cryptos.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off,
                              color: Colors.grey[600], size: 50),
                          const SizedBox(height: 10),
                          Text(
                            'Nenhuma criptomoeda encontrada para os símbolos informados.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => viewModel.fetchCryptoCurrencies(
                      symbols: _searchController.text.trim()),
                  child: ListView.builder(
                    itemCount: viewModel.cryptos.length,
                    itemBuilder: (context, index) {
                      final crypto = viewModel.cryptos[index];
                      return CryptoListItem(
                        crypto: crypto,
                        onTap: () => showCryptoDetailDialog(context, crypto),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
