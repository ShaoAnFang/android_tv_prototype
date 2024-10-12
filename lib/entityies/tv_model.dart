class TVModel {
  bool adult = false;
  String backdropPath = "";
  List<int> genreIds = [];
  int id = 0;
  List<String> originCountry = [];
  String originalLanguage = "";
  String originalName = "";
  String overview = "";
  double popularity = 0.0;
  String posterPath = "";
  String firstAirDate = "1";
  String name = "";
  double voteAverage = 0.0;
  int voteCount = 0;

  TVModel();

  TVModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    if (json['genre_ids'] != null) {
      genreIds = List<int>.from(json['genre_ids'].map((e) => e));
    }

    id = json['id'];
    if (json['genre_ids'] != null) {
      originCountry = List<String>.from(json['origin_country'].map((e) => e));
    }
    originalLanguage = json['original_language'] ?? "";
    originalName = json['original_name'] ?? "";
    overview = json['overview'] ?? "";
    popularity = json['popularity'] ?? "";
    posterPath = json['poster_path'] ?? "";
    firstAirDate = json['first_air_date'] ?? "";
    name = json['name'] ?? "";
    voteAverage = json['vote_average'] ?? 0.0;
    voteCount = json['vote_count'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['origin_country'] = originCountry;
    data['original_language'] = originalLanguage;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['first_air_date'] = firstAirDate;
    data['name'] = name;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
