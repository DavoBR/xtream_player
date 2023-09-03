class EpisodeInfo {
  EpisodeInfo({
    required this.tmdbId,
    required this.releaseDate,
    required this.plot,
    required this.durationSecs,
    required this.duration,
    required this.movieImage,
    required this.bitrate,
    required this.rating,
    required this.season,
    required this.coverBig,
  });

  late final int tmdbId;
  late final String releaseDate;
  late final String plot;
  late final int durationSecs;
  late final String duration;
  late final String? movieImage;
  late final int bitrate;
  late final double rating;
  late final String season;
  late final String? coverBig;

  EpisodeInfo.fromJson(Map<String, dynamic> json) {
    tmdbId = int.parse(json['tmdb_id'].toString());
    releaseDate = json['release_date'];
    plot = json['plot'];
    durationSecs = json['duration_secs'];
    duration = json['duration'];
    movieImage = json['movie_image'];
    bitrate = json['bitrate'];
    rating = double.parse(json['rating'].toString());
    season = json['season'].toString();
    coverBig = json['cover_big'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tmdb_id'] = tmdbId;
    data['release_date'] = releaseDate;
    data['plot'] = plot;
    data['duration_secs'] = durationSecs;
    data['duration'] = duration;
    data['movie_image'] = movieImage;
    data['bitrate'] = bitrate;
    data['rating'] = rating;
    data['season'] = season;
    data['cover_big'] = coverBig;
    return data;
  }
}
