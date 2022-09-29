import 'package:flutter/material.dart';

class CryptoCurrencyScreen extends StatefulWidget {
  const CryptoCurrencyScreen({super.key});

  @override
  State<CryptoCurrencyScreen> createState() => _CryptoCurrencyScreenState();
}

class _CryptoCurrencyScreenState extends State<CryptoCurrencyScreen> {
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
        body: Padding(
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
                              // customersSearchString = value;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.black.withOpacity(0.1),
                              filled: true,
                              hintText: 'Enter currency pair',
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.w400),
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
                              icon: Icon(Icons.search),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
