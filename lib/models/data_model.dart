import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  User user;
  Recommend recommend;

  DataModel({
    required this.user,
    required this.recommend,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        user: User.fromJson(json["user"]),
        recommend: Recommend.fromJson(json["recommend"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "recommend": recommend.toJson(),
      };
}

class Recommend {
  List<Activity> activity;
  List<Activity> emotion;
  List<Activity> time;

  Recommend({
    required this.activity,
    required this.emotion,
    required this.time,
  });

  factory Recommend.fromJson(Map<String, dynamic> json) => Recommend(
        activity: List<Activity>.from(
            json["activity"].map((x) => Activity.fromJson(x))),
        emotion: List<Activity>.from(
            json["emotion"].map((x) => Activity.fromJson(x))),
        time:
            List<Activity>.from(json["time"].map((x) => Activity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "activity": List<dynamic>.from(activity.map((x) => x.toJson())),
        "emotion": List<dynamic>.from(emotion.map((x) => x.toJson())),
        "time": List<dynamic>.from(time.map((x) => x.toJson())),
      };
}

class Activity {
  int musicIndex;
  int albumIndex;
  int singerIndex;
  String singer;
  String song;
  String album;
  String lyrics;
  String genre;
  int musicTitme;
  DateTime albumReleased;

  Activity({
    required this.musicIndex,
    required this.albumIndex,
    required this.singerIndex,
    required this.singer,
    required this.song,
    required this.album,
    required this.lyrics,
    required this.genre,
    required this.musicTitme,
    required this.albumReleased,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        musicIndex: json["music_index"],
        albumIndex: json["album_index"],
        singerIndex: json["singer_index"],
        singer: json["singer"],
        song: json["song"],
        album: json["album"],
        lyrics: json["lyrics"],
        genre: json["genre"],
        musicTitme: json["music_titme"],
        albumReleased: DateTime.parse(json["album_released"]),
      );

  Map<String, dynamic> toJson() => {
        "music_index": musicIndex,
        "album_index": albumIndex,
        "singer_index": singerIndex,
        "singer": singer,
        "song": song,
        "album": album,
        "lyrics": lyrics,
        "genre": genre,
        "music_titme": musicTitme,
        "album_released":
            "${albumReleased.year.toString().padLeft(4, '0')}-${albumReleased.month.toString().padLeft(2, '0')}-${albumReleased.day.toString().padLeft(2, '0')}",
      };
}

class User {
  List<Activity> played;
  List<Activity> liked;
  List<Activity> singer;

  User({
    required this.played,
    required this.liked,
    required this.singer,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        played: List<Activity>.from(
            json["played"].map((x) => Activity.fromJson(x))),
        liked:
            List<Activity>.from(json["liked"].map((x) => Activity.fromJson(x))),
        singer: List<Activity>.from(
            json["singer"].map((x) => Activity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "played": List<dynamic>.from(played.map((x) => x.toJson())),
        "liked": List<dynamic>.from(liked.map((x) => x.toJson())),
        "singer": List<dynamic>.from(singer.map((x) => x.toJson())),
      };
}
