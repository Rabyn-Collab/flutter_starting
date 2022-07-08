



import 'package:dio/dio.dart';
import 'package:flutter_start_new/api_exceptions.dart';
import 'package:flutter_start_new/models/movie.dart';

class MovieService{


  static Future<List<Movie>> getMovieByCategory({required String apiPath, required int page})async {
    final dio = Dio();
           try{
             final response = await dio.get(apiPath, queryParameters: {
               'api_key': '2a0f926961d00c667e191a21c14461f8', 'language': 'en-Us',
               'page': page
             });
            final data = response.data['results'];
            final  movieData = (data as List).map((e) => Movie.fromJson(e)).toList();
             return movieData;
           }on DioError catch (err){
             throw DioException.fromDioError(err).errorMessage;
           }
  }


  static Future<List<Movie>> searchMovie({required String apiPath, required String searchText,  required int page})async {
    final dio = Dio();
    try{
      final response = await dio.get(apiPath, queryParameters: {
        'api_key': '2a0f926961d00c667e191a21c14461f8',
        'language': 'en-Us',
        'query': searchText,
        'page': page
      });
      final data = response.data['results'];
      if((data as List).isEmpty){
         return [Movie(
             title: 'no-data',
             id: 0, overview: '', poster_path: '', vote_average: '', release_date: '')];
      }else{
        final  movieData = data.map((e) => Movie.fromJson(e)).toList();
        return movieData;
      }

    }on DioError catch (err){
      throw DioException.fromDioError(err).errorMessage;
    }
  }



}

