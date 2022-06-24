import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start_new/models/book.dart';
import 'package:flutter_start_new/view/detail_page.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F5F9),
        appBar: AppBar(
          backgroundColor: Color(0xFFF1F5F9),
          elevation: 0,
          title: Text('Hi John,', style: TextStyle(color: Colors.black),),
          actions: [

            IconButton(
                onPressed: (){

                },
                icon: Icon(CupertinoIcons.ant_fill, color: Colors.black,)
            ),
            IconButton(
                onPressed: (){

                },
                icon: Icon(Icons.notification_important_rounded, color: Colors.black,)
            ),
          ],
        ),
        body: Container(
          child: Column(
              children: [
                Image.network('https://images.unsplash.com/photo-1589998059171-988d887df646?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Ym9va3xlbnwwfDB8MHx8&auto=format&fit=crop&w=500&q=60',
                 height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20,),
                Container(
                  height: 245,
                 child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                     itemCount: books.length,
                     itemBuilder: (context, index){
                     final book = books[index];
                        return InkWell(
                          onTap: (){
                     Get.to(() => DetailPage(book), transition: Transition.leftToRight);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10, left:index == 0 ? 10 : 0),
                            width: 360,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                    child: Hero(
                                        tag: book.imageUrl,
                                        child: Image.network(book.imageUrl))),
                                Expanded(
                                  child: Container(
                                    height: 200,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(book.label),
                                            Text(book.overview, maxLines: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(book.rating),
                                                Text(book.genre)
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                     }
                 ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('You may also like', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),)),
                ),

              Container(
                padding: EdgeInsets.only(left: 10),
                height: 207,
               child: ListView.builder(
                 itemCount: books.length,
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (context, index){
                   final book = books[index];
                     return Container(
                       width: 150,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                             child: CachedNetworkImage(
                               placeholder: (context, str){
                                 return Center(child: CircularProgressIndicator(
                                   color: Colors.purple,
                                 ));
                               },
                               imageUrl: book.imageUrl,
                               height: 150,
                               fit: BoxFit.fitHeight,),
                           ),
                           Text(book.label),
                           Text(book.genre, style: TextStyle(color: Colors.blueGrey),)
                         ],
                       ),
                     );
                   }
               ),
              )

              ],
          ),
        )
    );
  }
}


