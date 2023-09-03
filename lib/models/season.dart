class Season {
  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
    required this.voteAverage,
    required this.cover,
    required this.coverBig,
  });

  late final String airDate;
  late final int episodeCount;
  late final int id;
  late final String name;
  late final String overview;
  late final int seasonNumber;
  late final double voteAverage;
  late final String cover;
  late final String coverBig;

  Season.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'] ?? '';
    episodeCount = json['episode_count'] ?? 0;
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    overview = json['overview'] ?? '';
    seasonNumber = json['season_number'] ?? 0;
    voteAverage = double.parse(json['vote_average'].toString());
    cover = json['cover'] ?? '';
    coverBig = json['cover_big'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_count'] = episodeCount;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['season_number'] = seasonNumber;
    data['vote_average'] = voteAverage;
    data['cover'] = cover;
    data['cover_big'] = coverBig;
    return data;
  }
}
