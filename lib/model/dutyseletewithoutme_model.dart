// To parse this JSON data, do
//
//     final dutySeletewithoutme = dutySeletewithoutmeFromJson(jsonString);

import 'dart:convert';

DutySeletewithoutme dutySeletewithoutmeFromJson(String str) => DutySeletewithoutme.fromJson(json.decode(str));

String dutySeletewithoutmeToJson(DutySeletewithoutme data) => json.encode(data.toJson());

class DutySeletewithoutme {
    DutySeletewithoutme({
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

    factory DutySeletewithoutme.fromJson(Map<String, dynamic> json) => DutySeletewithoutme(
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
