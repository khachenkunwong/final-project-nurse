// To parse this JSON data, do
//
//     final getListnameAll = getListnameAllFromJson(jsonString);

import 'dart:convert';

GetListnameAll getListnameAllFromJson(String str) =>
    GetListnameAll.fromJson(json.decode(str));

String getListnameAllToJson(GetListnameAll data) => json.encode(data.toJson());

class GetListnameAll {
  GetListnameAll({
    this.users,
  });

  List<User>? users;

  factory GetListnameAll.fromJson(Map<String, dynamic> json) => GetListnameAll(
        users: json["users"] == null
            ? null
            : List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": users == null
            ? null
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.id,
    this.fristName,
    this.lastName,
    this.actor,
    this.groups,
  });

  String? id;
  String? fristName;
  String? lastName;
  String? actor;
  List<Group>? groups;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] == null ? null : json["_id"],
        fristName: json["frist_name"] == null ? null : json["frist_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        actor: json["actor"] == null ? null : json["actor"],
        groups: json["groups"] == null
            ? null
            : List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "frist_name": fristName == null ? null : fristName,
        "last_name": lastName == null ? null : lastName,
        "actor": actor == null ? null : actor,
        "groups": groups == null
            ? null
            : List<dynamic>.from(groups!.map((x) => x.toJson())),
      };
}

class Group {
  Group({
    this.nameGroup,
  });

  String? nameGroup;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        nameGroup: json["name_group"] == null ? null : json["name_group"],
      );

  Map<String, dynamic> toJson() => {
        "name_group": nameGroup == null ? null : nameGroup,
      };
}
