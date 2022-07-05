import 'package:flutter_start_new/api.dart';
import 'package:flutter_start_new/models/movie.dart';



class MovieState{

  final String apiPath;
  final String searchText;
  final List<Movie> movies;
  final int page;


  MovieState({
    required this.apiPath,
    required this.movies,
    required this.searchText,
    required this.page
});


  MovieState.initSate() : searchText='',  movies=[], apiPath=Api.popular, page=1;


  MovieState copyWith({ String? apiPath, String? searchText, List<Movie>? movies, int? page}){
    return MovieState(
      movies: movies ?? this.movies,
      apiPath: apiPath ?? this.apiPath,
      page: page ?? this.page,
      searchText: searchText ?? this.searchText
    );
  }



}