import 'package:flutter/material.dart';



class LoadingUi extends StatelessWidget {
final double h;
LoadingUi(this.h);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: h * 0.9,
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.purple,
        ),
      ),
    );
  }
}
