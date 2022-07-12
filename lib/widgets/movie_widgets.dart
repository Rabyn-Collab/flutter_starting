import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/models/movie_state.dart';
import 'package:flutter_start_new/provider/movie_provider.dart';
import 'package:flutter_start_new/view/detail_page.dart';
import 'package:get/get.dart';




class MovieWidget extends StatelessWidget {
  MovieState movieState;
  final WidgetRef ref;
  double h;
  MovieWidget(this.movieState, this.h, this.ref);

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
            itemCount: movieState.movies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 2 / 3
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(() =>
                      DetailPage(movieState.movies[index]),
                      transition: Transition.leftToRight);
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                        errorWidget: (c, s, d) {
                          return Image.asset(
                              'assets/images/no_image.jpg');
                        },
                        imageUrl: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movieState
                            .movies[index].poster_path}')),
              );
            }
        ),
      ),
    );
  }
}
