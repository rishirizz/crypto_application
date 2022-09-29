import 'package:crypto_app/api_service/api_service.dart';
import 'package:crypto_app/components/text_styles.dart';
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
  bool isOrderBookViewed = false;
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
                                Text(
                                  'BTCUSD',
                                  style: cryptoNameStyle,
                                ),
                                Text(
                                  DateFormat.yMMMEd()
                                      .add_Hms()
                                      .format(DateTime.now()),
                                  style: secondaryTextStyle,
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
                                    Text(
                                      'OPEN',
                                      style: primaryTextStyle,
                                    ),
                                    Text(
                                      '\$ ${cryptoMap['open']}',
                                      style: cryptoValueStyle,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'HIGH',
                                      style: primaryTextStyle,
                                    ),
                                    Text(
                                      '\$ ${cryptoMap['high']}',
                                      style: cryptoValueStyle,
                                    ),
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
                                    Text(
                                      'LOW',
                                      style: primaryTextStyle,
                                    ),
                                    Text(
                                      '\$ ${cryptoMap['low']}',
                                      style: cryptoValueStyle,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'LAST',
                                      style: primaryTextStyle,
                                    ),
                                    Text(
                                      '\$ ${cryptoMap['last']}',
                                      style: cryptoValueStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'VOLUME',
                              style: primaryTextStyle,
                            ),
                            Text(
                              '\$ ${cryptoMap['volume']}',
                              style: cryptoValueStyle,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isOrderBookViewed = !isOrderBookViewed;
                                });
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  (!isOrderBookViewed)
                                      ? 'VIEW ORDER BOOK'
                                      : 'HIDE ORDER BOOK',
                                  style: cryptoValueStyle.copyWith(
                                    color: Colors.purple,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (isOrderBookViewed)
                              Card(
                                child: Text('sadafsg'),
                              )
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
