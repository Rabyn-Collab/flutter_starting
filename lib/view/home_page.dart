import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/provider/movie_provider.dart';
import 'package:flutter_start_new/widgets/movie_widgets.dart';
import 'package:flutter_start_new/widgets/popular_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../api.dart';



class HomePage extends ConsumerWidget {

  final searchController = TextEditingController();
@override
  Widget build(BuildContext context, ref) {

    final h = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
              tabs: [
            Tab(
              text: 'Popular',
            ),
                Tab(
                  text: 'Top_rated',
                ),
                Tab(
                  text: 'Upcoming',
                ),
          ]),
        ),
        resizeToAvoidBottomInset: false,
          body: KeyboardDismisser(
            gestures: [
              GestureType.onTap,
              GestureType.onPanUpdateDownDirection,
            ],
            child: SafeArea(
              child: Consumer(
                  builder: (context, ref, child) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          height: h * 0.1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15),
                            child: TextFormField(
                              controller: searchController,
                              onFieldSubmitted: (val) {
                                  // ref.read(movieProvider.notifier)
                                  //     .searchMovie(val);
                                  // searchController.clear();
                              },
                              autofocus: false,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  border: OutlineInputBorder()
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                              children: [
                               PopularWidget(Api.popular),
                               MovieWidget(Api.top_rated),
                               MovieWidget(Api.upcoming),
                          ]),
                        )

                      ],
                    );
                  }
              ),)
          )

      ),
    );
  }
}
