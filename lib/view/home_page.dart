import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/api.dart';
import 'package:flutter_start_new/common_widgets/connection_ui.dart';
import 'package:flutter_start_new/common_widgets/error_ui.dart';
import 'package:flutter_start_new/common_widgets/loading_ui.dart';
import 'package:flutter_start_new/provider/movie_provider.dart';
import 'package:flutter_start_new/view/detail_page.dart';
import 'package:flutter_start_new/widgets/movie_widgets.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
          child: OfflineBuilder(
            debounceDuration: Duration(seconds: 1),
        child: Container(),
        connectivityBuilder: ( context,ConnectivityResult connectivity, Widget child,) {
          final bool connected = connectivity != ConnectivityResult.none;
       //   print(connected);
          return SafeArea(
            child: Consumer(
                builder: (context, ref, child) {
                  final box = Hive.box('cached');
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: TextFormField(
                                    controller: searchController,
                                    onFieldSubmitted: (val) {
                                      ref.read(movieProvider.notifier)
                                          .searchMovie(val);
                                      searchController.clear();
                                    },
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        border: OutlineInputBorder()
                                    ),
                                  ),
                                )),
                            PopupMenuButton(
                                onSelected: (val) {
                                  ref.read(movieProvider.notifier)
                                      .updateMovieByCategory(val as String,connected);
                                },
                                child: Icon(Icons.menu, size: 40,),
                                itemBuilder: (context) =>
                                [
                                  PopupMenuItem(
                                      onTap: () {
                                        FocusManager.instance.primaryFocus!
                                            .unfocus();
                                      },
                                      value: Api.popular,
                                      child: Text('popular')
                                  ),
                                  PopupMenuItem(
                                      onTap: () {
                                        FocusManager.instance.primaryFocus!
                                            .unfocus();
                                      },
                                      value: Api.top_rated,
                                      child: Text('top_rated')
                                  ),
                                  PopupMenuItem(
                                      value: Api.upcoming,
                                      onTap: () {
                                        FocusManager.instance.primaryFocus!
                                            .unfocus();
                                      },
                                      child: Text('upcoming')
                                  ),
                                ]
                            )
                          ],
                        ),
                      ),


             connected ?       movieState.movies.isEmpty ? Center(child: CircularProgressIndicator()):
                 movieState.errorMessage.isNotEmpty ?  Center(child: Text(movieState.errorMessage),) :
                   MovieWidget(movieState, h, ref) : movieState.apiPath == Api.popular? MovieWidget(movieState, h, ref) :  ConnectionUi()

                    ],
                  );
                }
            ),
          );
        }
          ),
        )
    );
  }
}
