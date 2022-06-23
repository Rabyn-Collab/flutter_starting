import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_start_new/view/home_page.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Sample1(),
    );
  }
}


class Sample1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final topHeight = MediaQuery.of(context).padding.top;
    final topBottom = MediaQuery.of(context).padding.bottom;
    final h = height - topHeight;

    return Scaffold(
        body: SafeArea(
          child: Container(
            height: h.ceil().toDouble(),
            child: Column(
              children: [
                Container(
                  height: height * 0.20,
                  width: width,
                  color: Colors.black,
                ),
                Container(
                  height: height * 0.25,
                  width: width,
                  color: Colors.purple,
                ),
                Container(
                  height: height * 0.25,
                  width: width,
                  color: Colors.grey,
                ),
                Container(
                  height: height * 0.25,
                  width: width,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        )
        // Container(
        //   width: double.infinity,
        //   height: 500,
        //   color: Colors.blueGrey,
        //   child: Column(
        //     children: [
        //       Expanded(
        //         child: Container(
        //           color: Colors.red,
        //         ),
        //       ),
        //       Expanded(
        //           child: Container(
        //             width: double.infinity,
        //             color: Colors.purple,
        //         child: Text('sdlfklkds'),
        //       ))
        //     ],
        //   ),
        // )

    );
  }
}





class Sample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child:Wrap(
        children: [
          _buildContainer(),
          _buildContainer(),
          _buildContainer(),
          _buildContainer(),
          _buildContainer(),
        ],
      ),
    ));
  }

  Container _buildContainer() {
    return Container(
      margin: EdgeInsets.only(right: 10, bottom: 10),
      height: 100,
      width: 100,
      color: Colors.purple,
    );
  }
}

class Homes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: 700,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.black,
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.purple,
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.amber,
            ),
          ],
        ),
      ),
    ));
  }
}
