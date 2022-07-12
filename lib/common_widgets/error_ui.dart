import 'package:flutter/material.dart';

import '../provider/movie_provider.dart';




class ErrorUi extends StatelessWidget {
 final ref;

 ErrorUi(this.ref);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('try using another keyword',
              style: TextStyle(fontSize: 17),),
            ElevatedButton(
                onPressed: () {
                  ref.refresh(movieProvider.notifier);
                }, child: Text('Refresh'))
          ],
        ),
      ),
    );
  }
}
