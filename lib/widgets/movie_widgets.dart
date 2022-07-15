import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/api.dart';
import 'package:flutter_start_new/connectivity_check.dart';
import 'package:flutter_start_new/models/movie_state.dart';
import 'package:flutter_start_new/provider/movie_provider.dart';


class MovieWidget extends StatelessWidget {
  MovieState movieState;
  final WidgetRef ref;
  double h;
  final NetworkStatus connected;
  final String apiPath;
  MovieWidget(this.movieState, this.h, this.ref, this.connected, this.apiPath);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (onNotification) {
        if (onNotification is ScrollEndNotification) {
          final before = onNotification.metrics.extentBefore;
          final max = onNotification.metrics.maxScrollExtent;
          if (before == max) {

              ref.read(movieProvider.notifier).loadMore();
          }
        }
        return true;
      },
      child: Container(
        height: h * 0.9,
        child: GridView.builder(
            itemCount: apiPath == Api.popular && connected == NetworkStatus.Off? movieState.cachedMovie.length : movieState.movies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 2 / 3
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // if(connected){
                  //   Get.defaultDialog( content: Text('no connection'));
                  // }else{
                  //   Get.to(() =>
                  //       DetailPage(movieState.movies[index]),
                  //       transition: Transition.leftToRight);
                  // }

                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: apiPath == Api.popular && connected == NetworkStatus.Off? CachedNetworkImage(
                        errorWidget: (c, s, d) {
                          return  Image.asset(
                              'assets/images/no_image.jpg');
                        },
                        imageUrl: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movieState
                            .cachedMovie[index].poster_path}') :  CachedNetworkImage(
                        errorWidget: (c, s, d) {
                          return  Image.asset(
                              'assets/images/no_image.jpg');
                        },
                        imageUrl: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movieState
                            .movies[index].poster_path}')
                )
              );
            }
        ),
      ),
    );
  }
}
