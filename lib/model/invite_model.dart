// To parse this JSON data, do
//
//     final inviteModel = inviteModelFromJson(jsonString);

import 'dart:convert';

InviteModel inviteModelFromJson(String str) => InviteModel.fromJson(json.decode(str));

String inviteModelToJson(InviteModel data) => json.encode(data.toJson());

class InviteModel {
    InviteModel({
        this.invite,
    });

    List<Invite>? invite;

    factory InviteModel.fromJson(Map<String, dynamic> json) => InviteModel(
        invite: json["invite"] == null ? null : List<Invite>.from(json["invite"].map((x) => Invite.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "invite": invite == null ? null : List<dynamic>.from(invite!.map((x) => x.toJson())),
    };
}

class Invite {
    Invite({
        this.id,
        this.leader,
        this.group,
        this.member,
        this.show,
        this.apporve,
        this.v,
    });

    String? id;
    Leader? leader;
    Group? group;
    Leader? member;
    bool? show;
    bool? apporve;
    int? v;

    factory Invite.fromJson(Map<String, dynamic> json) => Invite(
        id: json["_id"] == null ? null : json["_id"],
        leader: json["_leader"] == null ? null : Leader.fromJson(json["_leader"]),
        group: json["_group"] == null ? null : Group.fromJson(json["_group"]),
        member: json["_member"] == null ? null : Leader.fromJson(json["_member"]),
        show: json["show"] == null ? null : json["show"],
        apporve: json["apporve"] == null ? null : json["apporve"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "_leader": leader == null ? null : leader!.toJson(),
        "_group": group == null ? null : group!.toJson(),
        "_member": member == null ? null : member!.toJson(),
        "show": show == null ? null : show,
        "apporve": apporve == null ? null : apporve,
        "__v": v == null ? null : v,
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

class Leader {
    Leader({
        this.id,
        this.fristName,
        this.lastName,
        this.email,
        this.password,
        this.actor,
        this.location,
        this.tokenVersion,
        this.v,
    });

    String? id;
    String? fristName;
    String? lastName;
    String? email;
    String? password;
    String? actor;
    String? location;
    int? tokenVersion;
    int? v;

    factory Leader.fromJson(Map<String, dynamic> json) => Leader(
        id: json["_id"] == null ? null : json["_id"],
        fristName: json["frist_name"] == null ? null : json["frist_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        actor: json["actor"] == null ? null : json["actor"],
        location: json["location"] == null ? null : json["location"],
        tokenVersion: json["tokenVersion"] == null ? null : json["tokenVersion"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "frist_name": fristName == null ? null : fristName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "actor": actor == null ? null : actor,
        "location": location == null ? null : location,
        "tokenVersion": tokenVersion == null ? null : tokenVersion,
        "__v": v == null ? null : v,
    };
}
