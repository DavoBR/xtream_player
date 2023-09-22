import '../models/enums.dart';
import '../models/settings.dart';

String translateTrackLanguage(String language) {
  switch (language) {
    case 'spa':
      return 'Spanish';
    case 'eng':
      return 'English';
    default:
      return language;
  }
}

String getStreamUrl(
  StreamType streamType,
  int streamId,
  String? extension,
  Settings settings,
) {
  if (extension == null) {
    switch (streamType) {
      case StreamType.live:
        extension = 'm3u8'; //ts
        break;
      case StreamType.movie:
      case StreamType.series:
        extension = 'mp4';
        break;
      default:
        throw Exception('Unknown stream type: ${streamType.name}');
    }
  }

  return [
    settings.serverUrlOrDefault,
    streamType.name,
    settings.username,
    settings.password,
    '$streamId.$extension'
  ].where((e) => e.isNotEmpty).join('/');
  
}
