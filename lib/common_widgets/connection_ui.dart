import 'package:flutter/material.dart';



class ConnectionUi extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
         Icon(Icons.wifi_off),
          Text('no connection'),
        ],
      ),
    );
  }
}
