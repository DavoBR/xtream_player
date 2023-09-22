import 'dart:convert';

class StreamInfo {
  final MovieInfo? info;
  final MovieData? movieData;

  StreamInfo({
    this.info,
    this.movieData,
  });

  factory StreamInfo.fromJson(Map<String, dynamic> json) => StreamInfo(
        info: json["info"] == null ? null : MovieInfo.fromJson(json["info"]),
        movieData: json["movie_data"] == null
            ? null
            : MovieData.fromJson(json["movie_data"]),
      );

  Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "movie_data": movieData?.toJson(),
      };
}

class MovieInfo {
  final int? tmdbId;
  final DateTime? releaseDate;
  final String? plot;
  final int? durationSecs;
  final String? duration;
  final String? movieImage;
  final int? bitrate;
  final double? rating;
  final String? season;
  final int? episodeRunTime;
  final String? coverBig;
  final List<String>? subtitles;

  MovieInfo({
    this.tmdbId,
    this.releaseDate,
    this.plot,
    this.durationSecs,
    this.duration,
    this.movieImage,
    this.bitrate,
    this.rating,
    this.season,
    this.episodeRunTime,
    this.coverBig,
    this.subtitles,
  });

  factory MovieInfo.fromRawJson(String str) =>
      MovieInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieInfo.fromJson(Map<String, dynamic> json) => MovieInfo(
        tmdbId: json["tmdb_id"],
        releaseDate: DateTime.tryParse(
          json["release_date"] ?? json['releasedate'] ?? '',
        ),
        plot: json["plot"],
        durationSecs: json["duration_secs"],
        duration: json["duration"],
        movieImage: json["movie_image"],
        bitrate: json["bitrate"],
        rating: json["rating"]?.toDouble(),
        season: json["season"],
        episodeRunTime: json["episode_run_time"],
        coverBig: json["cover_big"],
        subtitles: json["subtitles"] == null
            ? []
            : List<String>.from(json["subtitles"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "tmdb_id": tmdbId,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "plot": plot,
        "duration_secs": durationSecs,
        "duration": duration,
        "movie_image": movieImage,
        "bitrate": bitrate,
        "rating": rating,
        "season": season,
        "episode_run_time": episodeRunTime,
        "cover_big": coverBig,
        "subtitles": subtitles == null
            ? []
            : List<String>.from(subtitles!.map((x) => x)),
      };
}

class MovieData {
  final int? streamId;
  final String? name;
  final String? title;
  final dynamic year;
  final String? added;
  final String? categoryId;
  final List<int>? categoryIds;
  final String? containerExtension;
  final String? customSid;
  final String? directSource;

  MovieData({
    this.streamId,
    this.name,
    this.title,
    this.year,
    this.added,
    this.categoryId,
    this.categoryIds,
    this.containerExtension,
    this.customSid,
    this.directSource,
  });

  factory MovieData.fromRawJson(String str) =>
      MovieData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieData.fromJson(Map<String, dynamic> json) => MovieData(
        streamId: json["stream_id"],
        name: json["name"],
        title: json["title"],
        year: json["year"],
        added: json["added"],
        categoryId: json["category_id"],
        categoryIds: json["category_ids"] == null
            ? []
            : List<int>.from(json["category_ids"]!.map((x) => x)),
        containerExtension: json["container_extension"],
        customSid: json["custom_sid"],
        directSource: json["direct_source"],
      );

  Map<String, dynamic> toJson() => {
        "stream_id": streamId,
        "name": name,
        "title": title,
        "year": year,
        "added": added,
        "category_id": categoryId,
        "category_ids": categoryIds == null
            ? []
            : List<int>.from(categoryIds!.map((x) => x)),
        "container_extension": containerExtension,
        "custom_sid": customSid,
        "direct_source": directSource,
      };
}
