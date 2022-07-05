import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_start_new/models/movie_state.dart';
import 'package:flutter_start_new/services/movie_service.dart';



final movieProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) => MovieProvider(MovieState.initSate()));

class MovieProvider extends StateNotifier<MovieState>{
  MovieProvider(super.state){
      getMovie();
  }


  Future<void> getMovie() async{
    final response = await MovieService.getMovieByCategory(apiPath: state.apiPath, page: state.page);
    state = state.copyWith(
      movies: response
    );
  }




}





