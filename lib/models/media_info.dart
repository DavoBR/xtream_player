import 'enums.dart';
import 'settings.dart';

class MediaInfo {
  final int id;
  final int? parentId;
  final StreamType type;
  final String title;

  MediaInfo({
    required this.id,
    this.parentId,
    required this.type,
    required this.title,
  });

  String getUrl(Settings settings) {
    String extension;
    switch (type) {
      case StreamType.live:
        extension = 'm3u8';
        break;
      case StreamType.movie:
      case StreamType.series:
        extension = 'mp4';
        break;
      default:
        throw Exception('Unknown stream type: ${type.name}');
    }

    return [
      settings.serverUrl,
      type.name,
      settings.username,
      settings.password,
      '$id.$extension'
    ].join('/');
  }
}
