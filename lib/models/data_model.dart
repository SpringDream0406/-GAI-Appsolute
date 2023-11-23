import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  User user;
  Recommen recommen;

  DataModel({
    required this.user,
    required this.recommen,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        user: User.fromJson(json["user"]),
        recommen: Recommen.fromJson(json["recommen"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "recommen": recommen.toJson(),
      };
}

class Recommen {
  List<Condition> condition;
  List<Condition> emotion;
  List<Condition> time;

  Recommen({
    required this.condition,
    required this.emotion,
    required this.time,
  });

  factory Recommen.fromJson(Map<String, dynamic> json) => Recommen(
        condition: List<Condition>.from(
            json["condition"].map((x) => Condition.fromJson(x))),
        emotion: List<Condition>.from(
            json["emotion"].map((x) => Condition.fromJson(x))),
        time: List<Condition>.from(
            json["time"].map((x) => Condition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "condition": List<dynamic>.from(condition.map((x) => x.toJson())),
        "emotion": List<dynamic>.from(emotion.map((x) => x.toJson())),
        "time": List<dynamic>.from(time.map((x) => x.toJson())),
      };
}

class Condition {
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
  Type1 type1;
  Type2 type2;
  String type3;
  UserId? userId;
  DateTime? addedAt;

  Condition({
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
    required this.type1,
    required this.type2,
    required this.type3,
    this.userId,
    this.addedAt,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
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
        type1: type1Values.map[json["type1"]]!,
        type2: type2Values.map[json["type2"]]!,
        type3: json["type3"],
        userId: userIdValues.map[json["user_id"]],
        addedAt:
            json["added_at"] == null ? null : DateTime.parse(json["added_at"]),
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
        "type1": type1Values.reverse[type1],
        "type2": type2Values.reverse[type2],
        "type3": type3,
        "user_id": userIdValues.reverse[userId],
        "added_at": addedAt?.toIso8601String(),
      };
}

enum Type1 { EMPTY, FLUFFY, PURPLE, STICKY, TENTACLED, TYPE1 }

final type1Values = EnumValues({
  "분노": Type1.EMPTY,
  "열정적": Type1.FLUFFY,
  "기쁨": Type1.PURPLE,
  "안정": Type1.STICKY,
  "사랑": Type1.TENTACLED,
  "슬픔": Type1.TYPE1
});

enum Type2 { EMPTY, FLUFFY, PURPLE, TYPE2 }

final type2Values = EnumValues({
  "운동/훈련중": Type2.EMPTY,
  "차량/운전중": Type2.FLUFFY,
  "산책/걷는중": Type2.PURPLE,
  "휴식/수면": Type2.TYPE2
});

enum UserId { LEE89 }

final userIdValues = EnumValues({"lee89": UserId.LEE89});

class User {
  List<Condition> played;
  List<Condition> liked;
  List<Condition> singer;

  User({
    required this.played,
    required this.liked,
    required this.singer,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        played: List<Condition>.from(
            json["played"].map((x) => Condition.fromJson(x))),
        liked: List<Condition>.from(
            json["liked"].map((x) => Condition.fromJson(x))),
        singer: List<Condition>.from(
            json["singer"].map((x) => Condition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "played": List<dynamic>.from(played.map((x) => x.toJson())),
        "liked": List<dynamic>.from(liked.map((x) => x.toJson())),
        "singer": List<dynamic>.from(singer.map((x) => x.toJson())),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
