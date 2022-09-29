import 'package:crypto_app/api_service/api_service.dart';
import 'package:crypto_app/screens/no_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CryptoCurrencyScreen extends StatefulWidget {
  const CryptoCurrencyScreen({super.key});

  @override
  State<CryptoCurrencyScreen> createState() => _CryptoCurrencyScreenState();
}

class _CryptoCurrencyScreenState extends State<CryptoCurrencyScreen> {
  bool dataPresent = true;
  bool isApiCallProcess = false;
  Map cryptoMap = {};

  @override
  void initState() {
    super.initState();
    getCryptoCurrency();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.sync,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.all(8),
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            TextField(
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                fillColor: Colors.black.withOpacity(0.1),
                                filled: true,
                                hintText: 'Enter currency pair',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.search),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                (!dataPresent)
                    ? const NoDataWidget()
                    : SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'BTCUSD',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                  ),
                                ),
                                Text(
                                  DateFormat.yMMMEd()
                                      .add_Hms()
                                      .format(DateTime.now()),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('OPEN'),
                                    Text('\$ ${cryptoMap['open']}'),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('HIGH'),
                                    Text('\$ ${cryptoMap['high']}'),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('LOW'),
                                    Text('\$ ${cryptoMap['low']}'),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('LAST'),
                                    Text('\$ ${cryptoMap['last']}'),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('VOLUME'),
                            Text('\$ ${cryptoMap['volume']}'),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getCryptoCurrency() {
    setState(() {
      isApiCallProcess = true;
    });
    getCryptoCurrencyData().then((response) {
      setState(() {
        isApiCallProcess = false;
        cryptoMap = Map<String, dynamic>.from(response);
        debugPrint('Response is ====> $cryptoMap');
      });
    });
  }
}
