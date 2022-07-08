import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/api.dart';
import 'package:flutter_start_new/provider/movie_provider.dart';
import 'package:flutter_start_new/view/detail_page.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';



class HomePage extends StatelessWidget {


  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: KeyboardDismisser(
          gestures: [
            GestureType.onTap,
            GestureType.onPanUpdateDownDirection,
          ],
          child: SafeArea(
            child: Consumer(
                builder: (context, ref, child) {
                  final movieState = ref.watch(movieProvider);
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        height: h * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: TextFormField(
                                    controller: searchController,
                                    onFieldSubmitted: (val){
                                      ref.read(movieProvider.notifier).searchMovie(val);
                                      searchController.clear();
                                    },
                                    autofocus: false,
                                    decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      border: OutlineInputBorder()
                                    ),
                                  ),
                                )),
                            PopupMenuButton(
                              onSelected: (val){
                             ref.read(movieProvider.notifier).updateMovieByCategory(val as String);
                              },
                              child: Icon(Icons.menu, size: 40,),
                                itemBuilder: (context) => [
                               PopupMenuItem(
                                 onTap: (){
                                   FocusManager.instance.primaryFocus!.unfocus();
                                 },
                                   value: Api.popular,
                                   child: Text('popular')
                               ),
                                  PopupMenuItem(
                                    onTap: (){
                                      FocusManager.instance.primaryFocus!.unfocus();
                                    },
                                      value: Api.top_rated,
                                      child: Text('top_rated')
                                  ),
                                  PopupMenuItem(
                                    value: Api.upcoming,
                                    onTap: (){
                                      FocusManager.instance.primaryFocus!.unfocus();
                                    },
                                      child: Text('upcoming')
                                  ),
                            ]
                            )
                          ],
                        ),
                      ),
                      movieState.isLoad ? Container(
                        height: h * 0.9,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),
                        ),
                      ) : movieState.errorMessage.isNotEmpty ?Container(
                        child: Center(child: Text(movieState.errorMessage),),
                      ) : movieState.movies[0].title == 'no-data' ? Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('try using another keyword', style: TextStyle(fontSize: 17),),
                              ElevatedButton(
                                  onPressed: (){
                                    ref.refresh(movieProvider.notifier);
                                  }, child: Text('Refresh'))
                            ],
                          ),
                        ),
                      ) : Container(
                        height: h * 0.9,
                        child: GridView.builder(
                            itemCount: movieState.movies.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: 2/3
                            ),
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  Get.to(() => DetailPage(movieState.movies[index]), transition: Transition.leftToRight);
                                },
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      errorWidget: (c, s,d){
                                        return Image.asset('assets/images/no_image.jpg');
                                      },
                                       imageUrl: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movieState.movies[index].poster_path}')),
                              );
                            }
                        ),
                      ),
                    ],
                  );
                }
    ),
          ),
        )
    );
  }
}
