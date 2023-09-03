import 'episode_info.dart';

class Episode {
  Episode({
    required this.id,
    required this.episodeNum,
    required this.title,
    required this.containerExtension,
    required this.info,
    required this.subtitles,
    required this.customSid,
    required this.added,
    required this.season,
    required this.directSource,
  });

  late final String id;
  late final String episodeNum;
  late final String title;
  late final String containerExtension;
  late final EpisodeInfo info;
  late final List<String> subtitles;
  late final String customSid;
  late final String added;
  late final int season;
  late final String directSource;

  Episode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    episodeNum = json['episode_num'];
    title = json['title'];
    containerExtension = json['container_extension'];
    info = EpisodeInfo.fromJson(json['info']);
    subtitles = List.castFrom<dynamic, String>(json['subtitles']);
    customSid = json['custom_sid'];
    added = json['added'];
    season = json['season'];
    directSource = json['direct_source'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['episode_num'] = episodeNum;
    data['title'] = title;
    data['container_extension'] = containerExtension;
    data['info'] = info.toJson();
    data['subtitles'] = subtitles;
    data['custom_sid'] = customSid;
    data['added'] = added;
    data['season'] = season;
    data['direct_source'] = directSource;
    return data;
  }
}
