import 'episode.dart';
import 'season.dart';
import 'serie_info.dart';

class SerieDetails {
  final List<Season> seasons;
  final SerieInfo info;
  final Map<String, List<Episode>> episodes;

  SerieDetails({
    required this.seasons,
    required this.info,
    required this.episodes,
  });

  factory SerieDetails.fromJson(Map<String, dynamic> json) => SerieDetails(
        seasons:
            List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
        info: SerieInfo.fromJson(json["info"]),
        episodes: Map.from(json["episodes"]).map((k, v) =>
            MapEntry<String, List<Episode>>(
                k, List<Episode>.from(v.map((x) => Episode.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "info": info.toJson(),
        "episodes": Map.from(episodes).map((k, v) => MapEntry<String, dynamic>(
            k, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
}
