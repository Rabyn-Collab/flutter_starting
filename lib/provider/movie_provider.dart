import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/api.dart';
import 'package:flutter_start_new/connectivity_check.dart';
import 'package:flutter_start_new/models/movie_state.dart';
import 'package:flutter_start_new/services/movie_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/movie.dart';



final connectionState = StateProvider<bool>((ref) => false);

final movieProvider = StateNotifierProvider.family<MovieProvider, MovieState, NetworkStatus>((ref, n) => MovieProvider(MovieState.initSate(), n));

class MovieProvider extends StateNotifier<MovieState>{
  MovieProvider(super.state, this.networkStatus){
    if(networkStatus == NetworkStatus.On){
      getMovie();
    }

  }

  NetworkStatus networkStatus;

  Future<void> getMovie() async{
    final box = Hive.box('cached');
    if(state.apiPath == Api.popular && box.isNotEmpty && networkStatus == NetworkStatus.Off){
        final data = box.get('popular');
       final movieModel = (jsonDecode(data)['results'] as List).map((e) => Movie.fromJson(e) ).toList();
        state = state.copyWith(
            cachedMovie: movieModel,
            errorMessage: ''
        );
    }else {
      try {
        List<Movie> _movies = [];
        if (state.searchText.isEmpty) {
          _movies = await MovieService.getMovieByCategory(
              apiPath: state.apiPath, page: state.page);
        } else {
          _movies = await MovieService.searchMovie(
              apiPath: state.apiPath, page: state.page,
              searchText: state.searchText
          );
        }
        state = state.copyWith(
            movies: [...state.movies, ..._movies],
            errorMessage: ''
        );
      } catch (err) {
        print(err);
        state = state.copyWith(
          errorMessage: err as String,
        );
      }
    }

  }


  void searchMovie(String searchText){
    state = state.copyWith(
        movies: [],
        page: 1,
        searchText: searchText,
        apiPath: Api.searchMovie
    );
    getMovie();

  }


  void updateMovieByCategory(String apiPath, NetworkStatus connectionStatus){
      if(connectionStatus == NetworkStatus.On){
        state = state.copyWith(
            movies: [],
            page: 1,
            apiPath: apiPath,
            searchText: ''
        );
         getMovie();
      }else if(apiPath == Api.popular){
          state = state.copyWith(
              movies: [],
              page: 1,
              apiPath: apiPath,
              searchText: ''
          );
          getMovie();
        }else if(apiPath != Api.popular){
        state = state.copyWith(
          movies: [],
            page: 1,
            apiPath: apiPath,
            searchText: ''
        );
      }


  }



  void loadMore(){
    state = state.copyWith(
        page:  state.page + 1,
        // searchText: ''
    );
    getMovie();

  }


}


final videoProvider  = FutureProvider.family((ref, int id) => VideoProvider().getVideoById(id));


class VideoProvider {
  Future<String> getVideoById(int id) async{
    final dio = Dio();
    final response = await dio.get('${Api.baseUrl}/$id/videos',
    queryParameters: {
      'api_key': '2a0f926961d00c667e191a21c14461f8'
    }
    );
    return response.data['results'][0]['key'];
  }
}

//
// final videoProvider  = StateNotifierProvider.family<VideoProvider, AsyncValue<String>,int>((ref, int id) => VideoProvider(AsyncData(''), id));
//
//
// class VideoProvider extends StateNotifier<AsyncValue<String>>{
//   VideoProvider(super.state, this.id){
//     getVideoById();
//   }
// final int id;
//
//   Future<void> getVideoById() async {
//     try {
//       state = AsyncLoading();
//     final response = await MovieService.getVideoById(id);
//     state = AsyncData(response);
//     } catch (err) {
//        state = AsyncError(err);
//     }
//   }
// }