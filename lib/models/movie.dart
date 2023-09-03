class Movie {
  int? num;
  String? name;
  String? title;
  String? year;
  String? streamType;
  int? streamId;
  String? streamIcon;
  double? rating;
  double? rating5Based;
  String? added;
  String? plot;
  String? cast;
  String? director;
  String? genre;
  String? releaseDate;
  String? youtubeTrailer;
  String? categoryId;
  List<int>? categoryIds;
  String? episodeRunTime;
  String? containerExtension;
  String? customSid;
  String? directSource;

  Movie({
    this.num,
    this.name,
    this.title,
    this.year,
    this.streamType,
    this.streamId,
    this.streamIcon,
    this.rating,
    this.rating5Based,
    this.added,
    this.plot,
    this.cast,
    this.director,
    this.genre,
    this.releaseDate,
    this.youtubeTrailer,
    this.episodeRunTime,
    this.categoryId,
    this.categoryIds,
    this.containerExtension,
    this.customSid,
    this.directSource,
  });

  Movie.fromJson(Map<String, dynamic> json) {
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
    if (json["stream_type"] is String) {
      streamType = json["stream_type"];
    }
    if (json["stream_id"] is int) {
      streamId = json["stream_id"];
    }
    if (json["stream_icon"] is String) {
      streamIcon = json["stream_icon"];
    }
    if (json["rating"] is double) {
      rating = json["rating"];
    }
    if (json["rating_5based"] is double) {
      rating5Based = json["rating_5based"];
    }
    if (json["added"] is String) {
      added = json["added"];
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
    if (json["youtube_trailer"] is String) {
      youtubeTrailer = json["youtube_trailer"];
    }
    if (json["episode_run_time"] is String || json["episode_run_time"] is int) {
      episodeRunTime = json["episode_run_time"].toString();
    }
    if (json["category_id"] is String) {
      categoryId = json["category_id"];
    }
    if (json["category_ids"] is List) {
      categoryIds = json["category_ids"] == null
          ? null
          : List<int>.from(json["category_ids"]);
    }
    if (json["container_extension"] is String) {
      containerExtension = json["container_extension"];
    }
    if (json["custom_sid"] is String) {
      customSid = json["custom_sid"];
    }
    if (json["direct_source"] is String) {
      directSource = json["direct_source"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["num"] = num;
    data["name"] = name;
    data["title"] = title;
    data["year"] = year;
    data["stream_type"] = streamType;
    data["stream_id"] = streamId;
    data["stream_icon"] = streamIcon;
    data["rating"] = rating;
    data["rating_5based"] = rating5Based;
    data["added"] = added;
    data["plot"] = plot;
    data["cast"] = cast;
    data["director"] = director;
    data["genre"] = genre;
    data["release_date"] = releaseDate;
    data["youtube_trailer"] = youtubeTrailer;
    data["episode_run_time"] = episodeRunTime;
    data["category_id"] = categoryId;
    if (categoryIds != null) {
      data["category_ids"] = categoryIds;
    }
    data["container_extension"] = containerExtension;
    data["custom_sid"] = customSid;
    data["direct_source"] = directSource;
    return data;
  }
}
