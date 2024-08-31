import 'dart:convert';

class RespuestaAreas {
    bool ok;
    int resp;
    String msg;
    List<Area> data;

    RespuestaAreas({
        required this.ok,
        required this.resp,
        required this.msg,
        required this.data,
    });

    factory RespuestaAreas.fromRawJson(String str) => RespuestaAreas.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RespuestaAreas.fromJson(Map<String, dynamic> json) => RespuestaAreas(
        ok: json["ok"],
        resp: json["resp"],
        msg: json["msg"],
        data: List<Area>.from(json["data"].map((x) => Area.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "resp": resp,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Area {
    int id;
    String name;
    int status;
    int idCompany;
    DateTime createdAt;
    DateTime updatedAt;

    Area({
        required this.id,
        required this.name,
        required this.status,
        required this.idCompany,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Area.fromRawJson(String str) => Area.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        idCompany: json["id_company"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "id_company": idCompany,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
