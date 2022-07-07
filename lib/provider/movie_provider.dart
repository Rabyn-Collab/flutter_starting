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





