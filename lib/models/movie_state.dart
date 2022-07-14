import 'package:flutter_start_new/api.dart';
import 'package:flutter_start_new/models/movie.dart';

//
// enum ErrorState{
//   noConnection,
//   checking,
//   noError,
// }


class MovieState{

  final String apiPath;
  final String searchText;
  final List<Movie> movies;
  final int page;
  final List<Movie> cachedMovie;
  final String errorMessage;


  MovieState({
    required this.apiPath,
    required this.movies,
    required this.searchText,
    required this.cachedMovie,
    required this.page,
    required this.errorMessage,
});


  MovieState.initSate() : searchText='',  movies=[], apiPath=Api.popular, page=1,  errorMessage='', cachedMovie =[];


  MovieState copyWith({ String? apiPath, String? searchText, List<Movie>? movies, int? page,
    bool? isLoad,
    String? errorMessage,
    List<Movie>? cachedMovie
  }){
    return MovieState(
      movies: movies ?? this.movies,
      apiPath: apiPath ?? this.apiPath,
      cachedMovie: cachedMovie ?? this.cachedMovie,
      page: page ?? this.page,
      searchText: searchText ?? this.searchText,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }



}