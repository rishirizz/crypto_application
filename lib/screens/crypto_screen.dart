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
  List<List> asksList = [];
  List<List> bidsList = [];
  List<String> cryptoCurrencyList = [
    'btcusd',
    'btceur',
    'btcgbp',
    'btcpax',
    'btcusdc',
    'gbpusd',
    'gbpeur',
    'eurusd',
    'xrpusd',
    'xrpeur',
    'xrpbtc',
    'xrpgbp',
    'xrppax',
    'ltcusd',
    'ltceur',
    'ltcbtc',
    'ltcgbp',
    'ethusd',
    'etheur',
    'ethbtc',
    'ethgbp',
    'ethpax',
    'ethusdc',
    'bchusd',
    'bcheur',
    'bchbtc',
    'bchgbp',
    'paxusd',
    'paxeur',
    'paxgbp',
    'xlmbtc',
    'xlmusd',
    'xlmeur',
    'xlmgbp',
    'linkusd',
    'linkeur',
    'linkgbp',
    'linkbtc',
    'linketh',
    'omgusd',
    'omgeur',
    'omggbp',
    'omgbtc',
    'usdcusd',
    'usdceur',
  ];

  @override
  void initState() {
    super.initState();
    cryptoTextController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: (dataPresent)
            ? FloatingActionButton(
                onPressed: () {
                  getTickerData();
                  getOrderBookData();
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
                            Autocomplete<String>(
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text == '') {
                                  setState(() {
                                    dataPresent = false;
                                    isOrderBookViewed = false;
                                  });
                                  return const Iterable<String>.empty();
                                }
                                return cryptoCurrencyList
                                    .where((String option) {
                                  return option.contains(
                                      textEditingValue.text.toLowerCase());
                                });
                              },
                              onSelected: (String selection) {
                                debugPrint('You just selected $selection');
                                cryptoTextController.text = selection;
                              },
                            ),
                            Positioned(
                              right: 10,
                              child: IconButton(
                                onPressed: () {
                                  if (cryptoTextController.text.isNotEmpty) {
                                    setState(() {
                                      dataPresent = true;
                                    });
                                    getTickerData();
                                    getOrderBookData();
                                  }
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
                                      (cryptoMap['open'] != null)
                                          ? '\$ ${cryptoMap['open']}'
                                          : '-----',
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
                                      (cryptoMap['high'] != null)
                                          ? '\$ ${cryptoMap['high']}'
                                          : '-----',
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
                                      (cryptoMap['low'] != null)
                                          ? '\$ ${cryptoMap['low']}'
                                          : '-----',
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
                                      (cryptoMap['last'] != null)
                                          ? '\$ ${cryptoMap['last']}'
                                          : '-----',
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
                              (cryptoMap['volume'] != null)
                                  ? '\$ ${cryptoMap['volume']}'
                                  : '-----',
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
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'QTY',
                                              style: tableHeadingTextStyle,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'QTY',
                                              style: tableHeadingTextStyle,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
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
                                            int reverseIndex = asksList.length -
                                                1 -
                                                index; //reversing the order for asksList
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    (bidsList.isNotEmpty &&
                                                            bidsList[index]
                                                                    [0] !=
                                                                null)
                                                        ? bidsList[index][0]
                                                            .toString()
                                                        : '-----',
                                                    style:
                                                        tablePrimaryTextStyle,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    (bidsList.isNotEmpty &&
                                                            bidsList[index]
                                                                    [1] !=
                                                                null)
                                                        ? bidsList[index][1]
                                                            .toString()
                                                        : '-----',
                                                    style:
                                                        tablePrimaryTextStyle,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    (asksList.isNotEmpty &&
                                                            asksList[reverseIndex]
                                                                    [1] !=
                                                                null)
                                                        ? asksList[reverseIndex]
                                                                [1]
                                                            .toString()
                                                        : '-----',
                                                    style:
                                                        tablePrimaryTextStyle,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    (asksList.isNotEmpty &&
                                                            asksList[reverseIndex]
                                                                    [0] !=
                                                                null)
                                                        ? asksList[reverseIndex]
                                                                [0]
                                                            .toString()
                                                        : '-----',
                                                    style:
                                                        tablePrimaryTextStyle,
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

  getTickerData() async {
    setState(() {
      isApiCallProcess = true;
    });
    getCryptoCurrencyTickerData(cryptoTextController.text).then((response) {
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
    getCryptoCurrencyOrderBookData(cryptoTextController.text).then((response) {
      setState(() {
        isSecondApiCallProcess = false;
        asksList = List<List<dynamic>>.from(response['asks']);
        bidsList = List<List<dynamic>>.from(response['bids']);
        debugPrint('Response is ====> $asksList');
      });
    });
  }

  @override
  void dispose() {
    cryptoTextController.dispose();
    super.dispose();
  }
}
