// To parse this JSON data, do
//
//     final presentModel = presentModelFromJson(jsonString);

import 'dart:convert';

PresentModel presentModelFromJson(String str) => PresentModel.fromJson(json.decode(str));

String presentModelToJson(PresentModel data) => json.encode(data.toJson());

class PresentModel {
    PresentModel({
        this.duty,
    });

    List<DutyPresent>? duty;

    factory PresentModel.fromJson(Map<String, dynamic> json) => PresentModel(
        duty: json["Duty"] == null ? null : List<DutyPresent>.from(json["Duty"].map((x) => DutyPresent.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Duty": duty == null ? null : List<dynamic>.from(duty!.map((x) => x.toJson())),
    };
}

class DutyPresent {
    DutyPresent({
        this.id,
        this.user,
        this.year,
        this.month,
        this.day,
        this.group,
        this.morning,
        this.noon,
        this.night,
        this.count,
        this.v,
    });

    String? id;
    UserPresent? user;
    String? year;
    String? month;
    String? day;
    String? group;
    int? morning;
    int? noon;
    int? night;
    int? count;
    int? v;

    factory DutyPresent.fromJson(Map<String, dynamic> json) => DutyPresent(
        id: json["_id"] == null ? null : json["_id"],
        user: json["_user"] == null ? null : UserPresent.fromJson(json["_user"]),
        year: json["year"] == null ? null : json["year"],
        month: json["month"] == null ? null : json["month"],
        day: json["day"] == null ? null : json["day"],
        group: json["group"] == null ? null : json["group"],
        morning: json["morning"] == null ? null : json["morning"],
        noon: json["noon"] == null ? null : json["noon"],
        night: json["night"] == null ? null : json["night"],
        count: json["count"] == null ? null : json["count"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "_user": user == null ? null : user?.toJson(),
        "year": year == null ? null : year,
        "month": month == null ? null : month,
        "day": day == null ? null : day,
        "group": group == null ? null : group,
        "morning": morning == null ? null : morning,
        "noon": noon == null ? null : noon,
        "night": night == null ? null : night,
        "count": count == null ? null : count,
        "__v": v == null ? null : v,
    };
}

class UserPresent {
    UserPresent({
        this.id,
        this.fristName,
        this.lastName,
        this.actor,
    });

    String? id;
    String? fristName;
    String? lastName;
    String? actor;

    factory UserPresent.fromJson(Map<String, dynamic> json) => UserPresent(
        id: json["_id"] == null ? null : json["_id"],
        fristName: json["frist_name"] == null ? null : json["frist_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        actor: json["actor"] == null ? null : json["actor"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "frist_name": fristName == null ? null : fristName,
        "last_name": lastName == null ? null : lastName,
        "actor": actor == null ? null : actor,
    };
}
