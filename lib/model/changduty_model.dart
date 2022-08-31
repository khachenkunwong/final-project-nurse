// To parse this JSON data, do
//
//     final changDuty = changDutyFromJson(jsonString);

import 'dart:convert';

List<ChangDuty> changDutyFromJson(String str) => List<ChangDuty>.from(json.decode(str).map((x) => ChangDuty.fromJson(x)));

String changDutyToJson(List<ChangDuty> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChangDuty {
    ChangDuty({
        this.id,
        this.user,
        this.year,
        this.month,
        this.day,
        this.changDutyGroup,
        this.noon,
        this.v,
        this.group,
        this.shift,
    });

    String? id;
    String? user;
    String? year;
    String? month;
    String? day;
    String? changDutyGroup;
    int? noon;
    int? v;
    String? group;
    List<Shift>? shift;

    factory ChangDuty.fromJson(Map<String, dynamic> json) => ChangDuty(
        id: json["_id"] == null ? null : json["_id"],
        user: json["_user"] == null ? null : json["_user"],
        year: json["year"] == null ? null : json["year"],
        month: json["month"] == null ? null : json["month"],
        day: json["day"] == null ? null : json["day"],
        changDutyGroup: json["group"] == null ? null : json["group"],
        noon: json["noon"] == null ? null : json["noon"],
        v: json["__v"] == null ? null : json["__v"],
        group: json["_group"] == null ? null : json["_group"],
        shift: json["shift"] == null ? null : List<Shift>.from(json["shift"].map((x) => Shift.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "_user": user == null ? null : user,
        "year": year == null ? null : year,
        "month": month == null ? null : month,
        "day": day == null ? null : day,
        "group": changDutyGroup == null ? null : changDutyGroup,
        "noon": noon == null ? null : noon,
        "__v": v == null ? null : v,
        "_group": group == null ? null : group,
        "shift": shift == null ? null : List<dynamic>.from(shift!.map((x) => x.toJson())),
    };
}

class Shift {
    Shift({
        this.morning,
        this.noon,
    });

    int? morning;
    int? noon;

    factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        morning: json["morning"] == null ? null : json["morning"],
        noon: json["noon"] == null ? null : json["noon"],
    );

    Map<String, dynamic> toJson() => {
        "morning": morning == null ? null : morning,
        "noon": noon == null ? null : noon,
    };
}
