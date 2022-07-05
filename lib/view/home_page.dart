import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/provider/movie_provider.dart';



class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Consumer(
              builder: (context, ref, child) {
                final movieState = ref.watch(movieProvider);
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      height: h * 0.1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.ideographic,
                        children: [
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    border: OutlineInputBorder()
                                  ),
                                ),
                              )),
                          PopupMenuButton(
                            child: Icon(Icons.menu, size: 40,),
                              itemBuilder: (context) => [
                             PopupMenuItem(
                                 child: Text('popular')
                             ),
                                PopupMenuItem(
                                    child: Text('top_rated')
                                ),
                                PopupMenuItem(
                                    child: Text('upcoming')
                                ),
                          ]
                          )
                        ],
                      ),
                    ),
                    movieState.movies.isEmpty ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.purple,
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
                            return ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network('https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movieState.movies[index].poster_path}'));
                          }
                      ),
                    ),
                  ],
                );
              }
    ),
        )
    );
  }
}
