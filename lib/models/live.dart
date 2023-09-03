class Live {
  int? num;
  String? name;
  String? streamType;
  int? streamId;
  String? streamIcon;
  String? epgChannelId;
  String? added;
  String? customSid;
  int? tvArchive;
  String? directSource;
  int? tvArchiveDuration;
  String? categoryId;
  List<int>? categoryIds;
  String? thumbnail;

  Live({
    this.num,
    this.name,
    this.streamType,
    this.streamId,
    this.streamIcon,
    this.epgChannelId,
    this.added,
    this.customSid,
    this.tvArchive,
    this.directSource,
    this.tvArchiveDuration,
    this.categoryId,
    this.categoryIds,
    this.thumbnail,
  });

  Live.fromJson(Map<String, dynamic> json) {
    if (json["num"] is int) {
      num = json["num"];
    }
    if (json["name"] is String) {
      name = json["name"];
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
    if (json["epg_channel_id"] is String) {
      epgChannelId = json["epg_channel_id"];
    }
    if (json["added"] is String) {
      added = json["added"];
    }
    if (json["custom_sid"] is String) {
      customSid = json["custom_sid"];
    }
    if (json["tv_archive"] is int) {
      tvArchive = json["tv_archive"];
    }
    if (json["direct_source"] is String) {
      directSource = json["direct_source"];
    }
    if (json["tv_archive_duration"] is int) {
      tvArchiveDuration = json["tv_archive_duration"];
    }
    if (json["category_id"] is String) {
      categoryId = json["category_id"];
    }
    if (json["category_ids"] is List) {
      categoryIds = json["category_ids"] == null
          ? null
          : List<int>.from(json["category_ids"]);
    }
    if (json["thumbnail"] is String) {
      thumbnail = json["thumbnail"];
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["num"] = num;
    data["name"] = name;
    data["stream_type"] = streamType;
    data["stream_id"] = streamId;
    data["stream_icon"] = streamIcon;
    data["epg_channel_id"] = epgChannelId;
    data["added"] = added;
    data["custom_sid"] = customSid;
    data["tv_archive"] = tvArchive;
    data["direct_source"] = directSource;
    data["tv_archive_duration"] = tvArchiveDuration;
    data["category_id"] = categoryId;
    if (categoryIds != null) {
      data["category_ids"] = categoryIds;
    }
    data["thumbnail"] = thumbnail;
    return data;
  }
}
