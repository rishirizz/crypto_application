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
  bool dataPresent = false;
  bool isApiCallProcess = false;
  bool isSecondApiCallProcess = false;
  bool isOrderBookViewed = false;
  Map cryptoMap = {};
  TextEditingController cryptoTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cryptoTextController.text = '';
    getTickerData();
    getOrderBookData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: (dataPresent)
            ? FloatingActionButton(
                onPressed: () {
                  getTickerData();
                },
                child: const Icon(
                  Icons.sync,
                ),
              )
            : null,
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
                              onChanged: (value) {
                                cryptoTextController.text = value;
                                if (value.isEmpty) {
                                  setState(() {
                                    dataPresent = false;
                                    isOrderBookViewed = false;
                                  });
                                }
                              },
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
                                onPressed: () {
                                  setState(() {
                                    if (cryptoTextController.text.length > 3) {
                                      dataPresent = true;
                                    }
                                  });
                                },
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
                                  cryptoTextController.text.toUpperCase(),
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
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isOrderBookViewed = !isOrderBookViewed;
                                  });
                                },
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
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'BID PRICE',
                                              style: tableHeadingTextStyle,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'QTY',
                                              style: tableHeadingTextStyle,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'QTY',
                                              style: tableHeadingTextStyle,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'ASK PRICE',
                                              style: tableHeadingTextStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: 5,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'BID PRICE',
                                                    style:
                                                        tableHeadingTextStyle,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'QTY',
                                                    style:
                                                        tableHeadingTextStyle,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'QTY',
                                                    style:
                                                        tableHeadingTextStyle,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'ASK PRICE',
                                                    style:
                                                        tableHeadingTextStyle,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
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

  getTickerData() {
    setState(() {
      isApiCallProcess = true;
    });
    getCryptoCurrencyTickerData().then((response) {
      setState(() {
        isApiCallProcess = false;
        cryptoMap = Map<String, dynamic>.from(response);
        debugPrint('Response is ====> $cryptoMap');
      });
    });
  }

  getOrderBookData() {
    setState(() {
      isSecondApiCallProcess = true;
    });
    getCryptoCurrencyOrderBookData().then((response) {
      setState(() {
        isSecondApiCallProcess = false;

        // cryptoMap = Map<String, dynamic>.from(response);
        debugPrint('Response is ====> $response');
      });
    });
  }
}
