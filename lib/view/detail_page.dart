import 'package:flutter/material.dart';
import 'package:flutter_start_new/models/book.dart';


class DetailPage extends StatelessWidget {
  final Book book;
DetailPage(this.book);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final topHeight = MediaQuery.of(context).padding.top;
    final h = height - topHeight;
    return Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                  Container(
                    height: h * 0.50,
                    width: double.infinity,
                    child: Hero(
                        tag: book.imageUrl,
                        child: Image.network(book.imageUrl, fit: BoxFit.cover,)),
                  ),


                Container(
                  height: h * 0.50,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(book.label),
                            Column(
                              children: [
                                Text(book.rating),
                                Text(book.genre),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(book.overview),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(160,50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                primary: Color(0xFF007083)
                              ),
                                onPressed: (){

                                }, child: Text('Read book')),
                            SizedBox(width: 10,),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    minimumSize: Size(160,50)
                                ),
                                onPressed: (){

                                }, child: Text('more info'))
                          ],
                        )
                      ],
                    ),
                  )
                  ,
                ),
              ],
            ),
          ),
        )
    );
  }
}
