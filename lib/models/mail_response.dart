// To parse this JSON data, do
//
//     final userMailResponse = userMailResponseFromJson(jsonString);

import 'dart:convert';

UserMailResponse userMailResponseFromJson(String str) =>
    UserMailResponse.fromJson(json.decode(str));

String userMailResponseToJson(UserMailResponse data) =>
    json.encode(data.toJson());

class UserMailResponse {
  String context;
  String id;
  String type;
  List<HydraMember> hydraMember;
  int hydraTotalItems;

  UserMailResponse({
    required this.context,
    required this.id,
    required this.type,
    required this.hydraMember,
    required this.hydraTotalItems,
  });

  factory UserMailResponse.fromJson(Map<String, dynamic> json) =>
      UserMailResponse(
        context: json["@context"],
        id: json["@id"],
        type: json["@type"],
        hydraMember: List<HydraMember>.from(
            json["hydra:member"].map((x) => HydraMember.fromJson(x))),
        hydraTotalItems: json["hydra:totalItems"],
      );

  Map<String, dynamic> toJson() => {
        "@context": context,
        "@id": id,
        "@type": type,
        "hydra:member": List<dynamic>.from(hydraMember.map((x) => x.toJson())),
        "hydra:totalItems": hydraTotalItems,
      };
}

class HydraMember {
  String id;
  String type;
  String hydraMemberId;
  String accountId;
  String msgid;
  From from;
  List<From> to;
  String subject;
  String intro;
  bool seen;
  bool isDeleted;
  bool hasAttachments;
  int size;
  String downloadUrl;
  DateTime createdAt;
  DateTime updatedAt;

  HydraMember({
    required this.id,
    required this.type,
    required this.hydraMemberId,
    required this.accountId,
    required this.msgid,
    required this.from,
    required this.to,
    required this.subject,
    required this.intro,
    required this.seen,
    required this.isDeleted,
    required this.hasAttachments,
    required this.size,
    required this.downloadUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HydraMember.fromJson(Map<String, dynamic> json) => HydraMember(
        id: json["@id"],
        type: json["@type"],
        hydraMemberId: json["id"],
        accountId: json["accountId"],
        msgid: json["msgid"],
        from: From.fromJson(json["from"]),
        to: List<From>.from(json["to"].map((x) => From.fromJson(x))),
        subject: json["subject"],
        intro: json["intro"],
        seen: json["seen"],
        isDeleted: json["isDeleted"],
        hasAttachments: json["hasAttachments"],
        size: json["size"],
        downloadUrl: json["downloadUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "@id": id,
        "@type": type,
        "id": hydraMemberId,
        "accountId": accountId,
        "msgid": msgid,
        "from": from.toJson(),
        "to": List<dynamic>.from(to.map((x) => x.toJson())),
        "subject": subject,
        "intro": intro,
        "seen": seen,
        "isDeleted": isDeleted,
        "hasAttachments": hasAttachments,
        "size": size,
        "downloadUrl": downloadUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class From {
  String address;
  String name;

  From({
    required this.address,
    required this.name,
  });

  factory From.fromJson(Map<String, dynamic> json) => From(
        address: json["address"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "name": name,
      };
}
