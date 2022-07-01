import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/provider/user_provider.dart';




class SamplePage extends StatelessWidget {
  const SamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final userData = ref.watch(userProvider);
              return  userData.when(
                  data: (data){
                    return ListView(
                      children: data.map((e) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: Column(
                                children: [
                                  Text(e.username),
                                  Text(e.address.street),
                                  ExpansionTile(
                                      title: Text('geo'),
                                    children: [
                                      Text('lat :- ${e.address.geo.lat}'),
                                      Text('lng :- ${e.address.geo.lng}'),
                                    ],
                                  )
                                ],
                              )
                          ),
                        );
                      }).toList(),
                    );
                  },
                  error: (err, stack) => Center(child: Text('$err')),
                  loading: () => Center(child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),)
              );
            }
              )
    );
  }
}
