// To parse this JSON data, do
//
//     final changMyDuty = changMyDutyFromJson(jsonString);

import 'dart:convert';

ChangMyDuty changMyDutyFromJson(String str) => ChangMyDuty.fromJson(json.decode(str));

String changMyDutyToJson(ChangMyDuty data) => json.encode(data.toJson());

class ChangMyDuty {
    ChangMyDuty({
        this.notifications,
    });

    List<Notification>? notifications;

    factory ChangMyDuty.fromJson(Map<String, dynamic> json) => ChangMyDuty(
        notifications: json["notifications"] == null ? null : List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "notifications": notifications == null ? null : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    };
}

class Notification {
    Notification({
        this.id,
        this.approveBy,
        this.user,
        this.fields,
        this.noift,
    });

    String? id;
    ApproveBy? approveBy;
    User? user;
    Fields? fields;
    String? noift;

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["_id"] == null ? null : json["_id"],
        approveBy: json["approve_by"] == null ? null : ApproveBy.fromJson(json["approve_by"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        fields: json["fields"] == null ? null : Fields.fromJson(json["fields"]),
        noift: json["noift"] == null ? null : json["noift"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "approve_by": approveBy == null ? null : approveBy!.toJson(),
        "user": user == null ? null : user!.toJson(),
        "fields": fields == null ? null : fields!.toJson(),
        "noift": noift == null ? null : noift,
    };
}

class ApproveBy {
    ApproveBy({
        this.fristName,
        this.lastName,
    });

    String? fristName;
    String? lastName;

    factory ApproveBy.fromJson(Map<String, dynamic> json) => ApproveBy(
        fristName: json["frist_name"] == null ? null : json["frist_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
    );

    Map<String, dynamic> toJson() => {
        "frist_name": fristName == null ? null : fristName,
        "last_name": lastName == null ? null : lastName,
    };
}

class Fields {
    Fields({
        this.prev,
        this.duty,
        this.group,
    });

    Prev? prev;
    Duty? duty;
    Group? group;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        prev: json["prev"] == null ? null : Prev.fromJson(json["prev"]),
        duty: json["duty"] == null ? null : Duty.fromJson(json["duty"]),
        group: json["group"] == null ? null : Group.fromJson(json["group"]),
    );

    Map<String, dynamic> toJson() => {
        "prev": prev == null ? null : prev!.toJson(),
        "duty": duty == null ? null : duty!.toJson(),
        "group": group == null ? null : group!.toJson(),
    };
}

class Duty {
    Duty({
        this.user,
        this.day,
        this.group,
        this.morning,
        this.noon,
        this.night,
        this.count,
    });

    String? user;
    var day;
    String? group;
    int? morning;
    int? noon;
    int? night;
    int? count;

    factory Duty.fromJson(Map<String, dynamic> json) => Duty(
        user: json["_user"] == null ? null : json["_user"],
        day: json["day"] == null ? null : json["day"],
        group: json["group"] == null ? null : json["group"],
        morning: json["morning"] == null ? null : json["morning"],
        noon: json["noon"] == null ? null : json["noon"],
        night: json["night"] == null ? null : json["night"],
        count: json["count"] == null ? null : json["count"],
    );

    Map<String, dynamic> toJson() => {
        "_user": user == null ? null : user,
        "day": day == null ? null : day,
        "group": group == null ? null : group,
        "morning": morning == null ? null : morning,
        "noon": noon == null ? null : noon,
        "night": night == null ? null : night,
        "count": count == null ? null : count,
    };
}

class Group {
    Group({
        this.id,
        this.location,
        this.nameGroup,
        this.leader,
        this.member,
        this.v,
    });

    String? id;
    String? location;
    String? nameGroup;
    List<String>? leader;
    List<String>? member;
    int? v;

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["_id"] == null ? null : json["_id"],
        location: json["location"] == null ? null : json["location"],
        nameGroup: json["name_group"] == null ? null : json["name_group"],
        leader: json["_leader"] == null ? null : List<String>.from(json["_leader"].map((x) => x)),
        member: json["_member"] == null ? null : List<String>.from(json["_member"].map((x) => x)),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "location": location == null ? null : location,
        "name_group": nameGroup == null ? null : nameGroup,
        "_leader": leader == null ? null : List<dynamic>.from(leader!.map((x) => x)),
        "_member": member == null ? null : List<dynamic>.from(member!.map((x) => x)),
        "__v": v == null ? null : v,
    };
}

class Prev {
    Prev({
        this.id,
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
    String? year;
    String? month;
    String? day;
    String? group;
    int? morning;
    int? noon;
    int? night;
    int? count;
    int? v;

    factory Prev.fromJson(Map<String, dynamic> json) => Prev(
        id: json["_id"] == null ? null : json["_id"],
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

class User {
    User({
        this.id,
        this.fristName,
        this.lastName,
    });

    String? id;
    String? fristName;
    String? lastName;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] == null ? null : json["_id"],
        fristName: json["frist_name"] == null ? null : json["frist_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "frist_name": fristName == null ? null : fristName,
        "last_name": lastName == null ? null : lastName,
    };
}
