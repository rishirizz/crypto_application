import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(
          Icons.search,
          size: 120,
          color: Color(0xff707070),
        ),
        SizedBox(
          height: 20,
        ),
        Text('Enter a currency pair to load data.')
      ],
    );
  }
}
