import 'dart:convert';

import 'package:crypto_app/constants/constants.dart';
import 'package:http/http.dart' as http;

Future getCryptoCurrencyData() async {
  Uri url = Uri.parse(cryptoApiPath);
  final response = await http.get(
    url,
  );
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Unable to load the data.');
  }
}
