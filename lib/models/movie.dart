


class Movie{

    final int id;
    final String title;
    final String overview;
    final String vote_average;
    final String poster_path;
    final String release_date;

    Movie({
      required this.title,
      required this.id,
      required this.overview,
      required this.poster_path,
      required this.vote_average,
      required this.release_date
    });

    factory Movie.fromJson(Map<String, dynamic> json){
      return Movie(
          title: json['title'] ?? 'no data0',
          id: json['id'],
          overview: json['overview'],
          poster_path: json['poster_path'] ?? '',
          vote_average:  '${json['vote_average']}',
        release_date: json['release_date']
      );
    }



}