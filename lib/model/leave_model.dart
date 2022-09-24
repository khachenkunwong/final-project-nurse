// To parse this JSON data, do
//
//     final getLeave = getLeaveFromJson(jsonString);

import 'dart:convert';

GetLeave getLeaveFromJson(String str) => GetLeave.fromJson(json.decode(str));

String getLeaveToJson(GetLeave data) => json.encode(data.toJson());

class GetLeave {
    GetLeave({
        this.data,
    });

    List<DatumLeave>? data;

    factory GetLeave.fromJson(Map<String, dynamic> json) => GetLeave(
        data: json["data"] == null ? null : List<DatumLeave>.from(json["data"].map((x) => DatumLeave.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DatumLeave {
    DatumLeave({
        this.id,
        this.location,
        this.user,
        this.type,
        this.detail,
        this.duty,
        this.shift,
        this.show,
        this.approve,
        this.v,
    });

    String? id;
    String? location;
    String? user;
    String? type;
    String? detail;
    String? duty;
    ShiftLeave? shift;
    bool? show;
    bool? approve;
    int? v;

    factory DatumLeave.fromJson(Map<String, dynamic> json) => DatumLeave(
        id: json["_id"] == null ? null : json["_id"],
        location: json["location"] == null ? null : json["location"],
        user: json["_user"] == null ? null : json["_user"],
        type: json["type"] == null ? null : json["type"],
        detail: json["detail"] == null ? null : json["detail"],
        duty: json["_duty"] == null ? null : json["_duty"],
        shift: json["shift"] == null ? null : ShiftLeave.fromJson(json["shift"]),
        show: json["show"] == null ? null : json["show"],
        approve: json["approve"] == null ? null : json["approve"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "location": location == null ? null : location,
        "_user": user == null ? null : user,
        "type": type == null ? null : type,
        "detail": detail == null ? null : detail,
        "_duty": duty == null ? null : duty,
        "shift": shift == null ? null : shift!.toJson(),
        "show": show == null ? null : show,
        "approve": approve == null ? null : approve,
        "__v": v == null ? null : v,
    };
}

class ShiftLeave {
    ShiftLeave({
        this.noon,
    });

    int? noon;

    factory ShiftLeave.fromJson(Map<String, dynamic> json) => ShiftLeave(
        noon: json["noon"] == null ? null : json["noon"],
    );

    Map<String, dynamic> toJson() => {
        "noon": noon == null ? null : noon,
    };
}
