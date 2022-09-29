import 'dart:convert';

import 'package:crypto_app/constants/constants.dart';
import 'package:http/http.dart' as http;

Future getCryptoCurrencyTickerData() async {
  Uri url = Uri.parse(cryptoApiTickerUrl + path);
  final response = await http.get(
    url,
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Unable to load the data.');
  }
}

Future getCryptoCurrencyOrderBookData() async {
  Uri url = Uri.parse(cryptoApiOrderBookUrl + path);
  final response = await http.get(
    url,
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Unable to load the data.');
  }
}
