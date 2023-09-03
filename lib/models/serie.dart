class Serie {
  Serie({
    this.num,
    this.name,
    this.title,
    this.year,
    required this.streamType,
    required this.seriesId,
    this.cover,
    this.plot,
    this.cast,
    this.director,
    this.genre,
    this.releaseDate,
    this.lastModified,
    this.rating,
    this.rating5Based,
    this.backdropPath,
    this.youtubeTrailer,
    this.episodeRunTime,
    this.categoryId,
    this.categoryIds,
  });

  int? num;
  String? name;
  String? title;
  String? year;
  late final String streamType;
  late final int seriesId;
  String? cover;
  String? plot;
  String? cast;
  String? director;
  String? genre;
  String? releaseDate;
  String? lastModified;
  String? rating;
  int? rating5Based;
  List<String>? backdropPath;
  String? youtubeTrailer;
  String? episodeRunTime;
  String? categoryId;
  List<int>? categoryIds;

  Serie.fromJson(Map<String, dynamic> json) {
    if (json["num"] is int) {
      num = json["num"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["year"] is String) {
      year = json["year"];
    }
    streamType = json["stream_type"];
    seriesId = json["series_id"];
    if (json["cover"] is String) {
      cover = json["cover"];
    }
    if (json["plot"] is String) {
      plot = json["plot"];
    }
    if (json["cast"] is String) {
      cast = json["cast"];
    }
    if (json["director"] is String) {
      director = json["director"];
    }
    if (json["genre"] is String) {
      genre = json["genre"];
    }
    if (json["release_date"] is String) {
      releaseDate = json["release_date"];
    }
    if (json["releaseDate"] is String) {
      releaseDate = json["releaseDate"];
    }
    if (json["last_modified"] is String) {
      lastModified = json["last_modified"];
    }
    if (json["rating"] is String) {
      rating = json["rating"];
    }
    if (json["rating_5based"] is int) {
      rating5Based = json["rating_5based"];
    }
    if (json["backdrop_path"] is List) {
      backdropPath = json["backdrop_path"] == null
          ? null
          : List<String>.from(json["backdrop_path"]);
    }
    if (json["youtube_trailer"] is String) {
      youtubeTrailer = json["youtube_trailer"];
    }
    if (json["episode_run_time"] is String) {
      episodeRunTime = json["episode_run_time"];
    }
    if (json["category_id"] is String) {
      categoryId = json["category_id"];
    }
    if (json["category_ids"] is List) {
      categoryIds = json["category_ids"] == null
          ? null
          : List<int>.from(json["category_ids"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["num"] = num;
    data["name"] = name;
    data["title"] = title;
    data["year"] = year;
    data["stream_type"] = streamType;
    data["series_id"] = seriesId;
    data["cover"] = cover;
    data["plot"] = plot;
    data["cast"] = cast;
    data["director"] = director;
    data["genre"] = genre;
    data["release_date"] = releaseDate;
    data["releaseDate"] = releaseDate;
    data["last_modified"] = lastModified;
    data["rating"] = rating;
    data["rating_5based"] = rating5Based;
    if (backdropPath != null) {
      data["backdrop_path"] = backdropPath;
    }
    data["youtube_trailer"] = youtubeTrailer;
    data["episode_run_time"] = episodeRunTime;
    data["category_id"] = categoryId;
    if (categoryIds != null) {
      data["category_ids"] = categoryIds;
    }
    return data;
  }
}
