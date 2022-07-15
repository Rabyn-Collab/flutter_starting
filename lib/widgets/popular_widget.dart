import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/provider/movie_provider.dart';

class PopularWidget extends StatelessWidget {
final String apiPath;
PopularWidget(this.apiPath);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final movieState =ref.watch(movieProvider(apiPath));
        return NotificationListener(
          onNotification: (onNotification) {
            if (onNotification is ScrollEndNotification) {
              final before = onNotification.metrics.extentBefore;
              final max = onNotification.metrics.maxScrollExtent;
              if (before == max) {

              }
            }
            return true;
          },
          child: Container(
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
                          child: CachedNetworkImage(
                              errorWidget: (c, s, d) {
                                return Image.asset(
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
    );
  }
}
