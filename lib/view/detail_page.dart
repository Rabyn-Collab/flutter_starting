import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/models/movie.dart';
import 'package:flutter_start_new/provider/movie_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';




class DetailPage extends StatelessWidget {
final Movie movie;
DetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, ori) {
        return WillPopScope(
          onWillPop: () async{
          if(ori == Orientation.landscape){
            SystemChrome.setPreferredOrientations(
                [
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown
                ]
            );
             return false;
          }else{
            return true;
          }
          },
          child: Scaffold(
              body: Consumer(
                  builder: (context, ref, child) {
                    final keyData = ref.watch(videoProvider(movie.id));
                    return ori == Orientation.landscape ? Container(
                      child:   keyData.when(
                          data: (data) {
                            return YoutubePlayer(
                              controller: YoutubePlayerController(
                                initialVideoId: data,
                                flags: YoutubePlayerFlags(
                                  autoPlay: true,
                                ),
                              ),
                              // showVideoProgressIndicator: true,
                            );
                          },
                          error: (err, stack) => Center(child: Text('$err')),
                          loading: () => Container()
                      ),
                    ) : Container(
                      child: ListView(
                        children: [
                          keyData.when(
                              data: (data) {
                                return Container(
                                  height: 220,
                                  child: YoutubePlayer(
                                    controller: YoutubePlayerController(
                                      initialVideoId: data,
                                      flags: YoutubePlayerFlags(
                                        autoPlay: false,
                                      ),
                                    ),
                                    // showVideoProgressIndicator: true,
                                  ),
                                );
                              },
                              error: (err, stack) => Center(child: Text('$err')),
                              loading: () => Container()
                          ),
                        ],
                      ),
                    );
                  }
              )
          ),
        );
      }
    );
  }
}
