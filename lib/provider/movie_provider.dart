import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/api.dart';
import 'package:flutter_start_new/models/movie_state.dart';
import 'package:flutter_start_new/services/movie_service.dart';



final movieProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) => MovieProvider(MovieState.initSate()));

class MovieProvider extends StateNotifier<MovieState>{
  MovieProvider(super.state){
      getMovie();
  }


  Future<void> getMovie() async{
    try{
      state = state.copyWith(isLoad: true);

      if(state.searchText.isEmpty){
        final response = await MovieService.getMovieByCategory(apiPath: state.apiPath, page: state.page);
        state = state.copyWith(isLoad: false);
        state = state.copyWith(
            movies: response
        );
      }else{
        final response = await MovieService.searchMovie(apiPath: state.apiPath, page: state.page,
        searchText: state.searchText
        );
        state = state.copyWith(isLoad: false);
        state = state.copyWith(
            movies: response
        );

      }


    }catch(err){
      state = state.copyWith(isLoad: false);
      state = state.copyWith(
        errorMessage: err as String
      );

    }

  }


  void searchMovie(String searchText){
    state = state.copyWith(
        movies: [],
        searchText: searchText,
        apiPath: Api.searchMovie
    );
    getMovie();

  }


  void updateMovieByCategory(String apiPath){
    state = state.copyWith(
      movies: [],
      apiPath: apiPath,
      searchText: ''
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