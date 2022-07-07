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
  final bool isLoad;
  final String errorMessage;


  MovieState({
    required this.apiPath,
    required this.movies,
    required this.searchText,
    required this.page,
    required this.errorMessage,
    required this.isLoad
});


  MovieState.initSate() : searchText='',  movies=[], apiPath=Api.popular, page=1, isLoad=false, errorMessage='';


  MovieState copyWith({ String? apiPath, String? searchText, List<Movie>? movies, int? page,
    bool? isLoad,
    String? errorMessage
  }){
    return MovieState(
      movies: movies ?? this.movies,
      apiPath: apiPath ?? this.apiPath,
      page: page ?? this.page,
      searchText: searchText ?? this.searchText,
      isLoad: isLoad ?? this.isLoad,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }



}