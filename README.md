# 📱 Cripto Moedas App

Aplicativo Flutter para visualização de cotações e detalhes de criptomoedas, com dados atualizados da CoinMarketCap.

## 🚀 Funcionalidades

- 📊 Listagem de criptomoedas com:
  - Sigla
  - Nome
  - Cotação atual em **USD** e **BRL**
- 📋 Detalhes da criptomoeda em `AlertDialog`:
  - Nome, símbolo, data de adição
  - Preço em USD e BRL
  - Variação percentual nas últimas 24h

## 🧩 Tecnologias Utilizadas

- **Flutter**
- **Dart**
- **Provider** (Gerenciamento de estado)
- **HTTP** (Requisições REST)
- **CoinMarketCap API** v1
- **Intl** (Formatação de moeda e datas)

## 🔐 API

Utiliza a API da [CoinMarketCap](https://coinmarketcap.com/api/) com uma chave de acesso gratuita.

- Endpoint utilizado:
https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest

- Conversão configurada para: `USD` e `BRL`

> ⚠️ Atenção: o plano gratuito da CoinMarketCap permite apenas **uma conversão por requisição**. Portanto, para mostrar múltiplas moedas, são necessárias chamadas com `convert=USD,BRL` ou ajustes no código com múltiplas requisições se necessário.

---

## 🛠️ Estrutura do Projeto

```bash
lib/
├── core/
│   ├── config/
│   │   └── app_constants.dart
│   └── failure/
│       └── failure.dart
├── data/
│   └── models/
│       └── crypto_currency_model.dart
├── domain/
│   ├── entities/
│   │   └── crypto_currency.dart
│   └── repositories/
│       └── crypto_repository.dart
├── presentation/
│   ├── viewmodels/
│   │   └── crypto_list_viewmodel.dart
│   ├── pages/
│   ├── widgets/
│   │   ├── crypto_list_item.dart
│   │   └── crypto_detail_dialog.dart
├── utils/
│   └── currency_formatter.dart
main.dart
```
🧪 Como executar
```bash
flutter pub get
flutter run
```

👨‍💻 Desenvolvedor
Pedro Toscano

