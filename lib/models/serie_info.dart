class SerieInfo {
  SerieInfo({
    required this.name,
    required this.title,
    required this.year,
    required this.cover,
    required this.plot,
    required this.cast,
    required this.director,
    required this.genre,
    required this.releaseDate,
    required this.lastModified,
    required this.rating,
    required this.rating5Based,
    required this.backdropPath,
    required this.youtubeTrailer,
    required this.episodeRunTime,
    required this.categoryId,
    required this.categoryIds,
  });

  late final String name;
  late final String title;
  late final String? year;
  late final String cover;
  late final String plot;
  late final String cast;
  late final String director;
  late final String genre;
  late final String releaseDate;
  late final String lastModified;
  late final String rating;
  late final num rating5Based;
  late final List<String> backdropPath;
  late final String youtubeTrailer;
  late final String episodeRunTime;
  late final String categoryId;
  late final List<int> categoryIds;

  SerieInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    year = json['year'];
    cover = json['cover'];
    plot = json['plot'] ?? '';
    cast = json['cast'];
    director = json['director'] ?? '';
    genre = json['genre'];
    releaseDate = json['release_date'] ?? json['releaseDate'];
    lastModified = json['last_modified'];
    rating = json['rating'];
    rating5Based = json['rating_5based'];
    backdropPath = List.castFrom<dynamic, String>(json['backdrop_path']);
    youtubeTrailer = json['youtube_trailer'] ?? '';
    episodeRunTime = json['episode_run_time'];
    categoryId = json['category_id'];
    categoryIds = List.castFrom<dynamic, int>(json['category_ids']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['title'] = title;
    data['year'] = year;
    data['cover'] = cover;
    data['plot'] = plot;
    data['cast'] = cast;
    data['director'] = director;
    data['genre'] = genre;
    data['release_date'] = releaseDate;
    data['releaseDate'] = releaseDate;
    data['last_modified'] = lastModified;
    data['rating'] = rating;
    data['rating_5based'] = rating5Based;
    data['backdrop_path'] = backdropPath;
    data['youtube_trailer'] = youtubeTrailer;
    data['episode_run_time'] = episodeRunTime;
    data['category_id'] = categoryId;
    data['category_ids'] = categoryIds;
    return data;
  }
}
