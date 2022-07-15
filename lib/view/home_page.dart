import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/api.dart';
import 'package:flutter_start_new/common_widgets/connection_ui.dart';
import 'package:flutter_start_new/connectivity_check.dart';
import 'package:flutter_start_new/models/movie_state.dart';
import 'package:flutter_start_new/provider/movie_provider.dart';
import 'package:flutter_start_new/widgets/movie_widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';



class HomePage extends ConsumerWidget {

  final searchController = TextEditingController();
@override
  Widget build(BuildContext context, ref) {
  final network = ref.watch(networkAwareProvider);
print(network);

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
                                      if(network == NetworkStatus.On) {
                                        ref.read(movieProvider.notifier)
                                            .searchMovie(val);
                                        searchController.clear();
                                      }
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
                                      .updateMovieByCategory(val as String, network);
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

             network == NetworkStatus.On ?   movieState.movies.isEmpty ? Center(child: CircularProgressIndicator()):
                 movieState.errorMessage.isNotEmpty ?  Center(child: Text(movieState.errorMessage),) :
                   MovieWidget(movieState, h, ref, network, movieState.apiPath) :  movieState.apiPath == Api.popular? movieState.errorMessage.isNotEmpty ? Center(child: Text(movieState.errorMessage)): MovieWidget(movieState, h, ref, network, movieState.apiPath) :  ConnectionUi()

                    ],
                  );
                }
            ),)
        )

    );
  }
}
