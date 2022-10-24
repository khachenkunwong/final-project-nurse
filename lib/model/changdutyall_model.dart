// To parse this JSON data, do
//
//     final cheagedutyall = cheagedutyallFromJson(jsonString);

import 'dart:convert';

Cheagedutyall cheagedutyallFromJson(String str) => Cheagedutyall.fromJson(json.decode(str));

String cheagedutyallToJson(Cheagedutyall data) => json.encode(data.toJson());

String meallToJson(Me data) => json.encode(data.toJson());

class Cheagedutyall {
    Cheagedutyall({
        this.me,
        this.withoutme,
    });

    List<Me>? me;
    List<Me>? withoutme;

    factory Cheagedutyall.fromJson(Map<String, dynamic> json) => Cheagedutyall(
        me: json["me"] == null ? null : List<Me>.from(json["me"].map((x) => Me.fromJson(x))),
        withoutme: json["withoutme"] == null ? null : List<Me>.from(json["withoutme"].map((x) => Me.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "me": me == null ? null : List<dynamic>.from(me!.map((x) => x.toJson())),
        "withoutme": withoutme == null ? null : List<dynamic>.from(withoutme!.map((x) => x.toJson())),
    };
}

class Me {
    Me({
        this.id,
        this.userId,
        this.year,
        this.month,
        this.day,
        this.group,
        this.v,
        this.dutyString,
        this.dutyNumber,
    });

    String? id;
    String? userId;
    int? year;
    int? month;
    int? day;
    String? group;
    int? v;
    String? dutyString;
    int? dutyNumber;

    factory Me.fromJson(Map<String, dynamic> json) => Me(
        id: json["id"] == null ? null : json["id"],
        userId: json["userID"] == null ? null : json["userID"],
        year: json["year"] == null ? null : json["year"],
        month: json["month"] == null ? null : json["month"],
        day: json["day"] == null ? null : json["day"],
        group: json["group"] == null ? null : json["group"],
        v: json["v"] == null ? null : json["v"],
        dutyString: json["dutyString"] == null ? null : json["dutyString"],
        dutyNumber: json["dutyNumber"] == null ? null : json["dutyNumber"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "userID": userId == null ? null : userId,
        "year": year == null ? null : year,
        "month": month == null ? null : month,
        "day": day == null ? null : day,
        "group": group == null ? null : group,
        "v": v == null ? null : v,
        "dutyString": dutyString == null ? null : dutyString,
        "dutyNumber": dutyNumber == null ? null : dutyNumber,
    };
}



// To parse this JSON data, do
//
//     final withoutmetojson = withoutmetojsonFromJson(jsonString);



Withoutmetojson withoutmetojsonFromJson(String str) => Withoutmetojson.fromJson(json.decode(str));

String withoutmetojsonToJson(Withoutmetojson data) => json.encode(data.toJson());

class Withoutmetojson {
    Withoutmetojson({
        this.id,
        this.userId,
        this.year,
        this.month,
        this.day,
        this.group,
        this.v,
        this.dutyString,
        this.dutyNumber,
    });

    String? id;
    String? userId;
    int? year;
    int? month;
    int? day;
    String? group;
    int? v;
    String? dutyString;
    int? dutyNumber;

    factory Withoutmetojson.fromJson(Map<String, dynamic> json) => Withoutmetojson(
        id: json["id"] == null ? null : json["id"],
        userId: json["userID"] == null ? null : json["userID"],
        year: json["year"] == null ? null : json["year"],
        month: json["month"] == null ? null : json["month"],
        day: json["day"] == null ? null : json["day"],
        group: json["group"] == null ? null : json["group"],
        v: json["v"] == null ? null : json["v"],
        dutyString: json["dutyString"] == null ? null : json["dutyString"],
        dutyNumber: json["dutyNumber"] == null ? null : json["dutyNumber"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "userID": userId == null ? null : userId,
        "year": year == null ? null : year,
        "month": month == null ? null : month,
        "day": day == null ? null : day,
        "group": group == null ? null : group,
        "v": v == null ? null : v,
        "dutyString": dutyString == null ? null : dutyString,
        "dutyNumber": dutyNumber == null ? null : dutyNumber,
    };
}

