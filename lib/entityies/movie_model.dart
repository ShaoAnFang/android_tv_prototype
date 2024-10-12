class MovieModel {
  bool adult = false;
  String backdropPath = '';
  List<int> genreIds = [];
  int id = 0;
  String originalLanguage = '';
  String originalTitle = '';
  String overview = '';
  double popularity = 0.0;
  String posterPath = '';
  String releaseDate = '';
  String title = '';
  bool video = false;
  double voteAverage = 0.0;
  int voteCount = 0;

  MovieModel();

  MovieModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'] ?? '';
    if (json['genre_id'] != null && json['genre_id'].isNotEmpty) {
      genreIds = List<int>.generate(json['genre_id'].length, (index) => json['genre_ids'][index]);
    }
    id = json['id'] ?? 0;
    originalLanguage = json['original_language'] ?? "";
    originalTitle = json['original_title'] ?? "";
    overview = json['overview'] ?? "";
    popularity = json['popularity'] ?? 0.0;
    posterPath = json['poster_path'] ?? "";
    releaseDate = json['release_date'] ?? "";
    title = json['title'] ?? "";
    video = json['video'] ?? "";
    if (json['vote_average'] != null || json['vote_average'] is int) {
      voteAverage = json['vote_average'].toDouble();
    } else {
      voteAverage = json['vote_average'] ;
    }
    voteCount = json['vote_count'] ?? 0;
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
