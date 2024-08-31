import 'dart:convert';

class RespuestaUsuario {
    bool ok;
    int resp;
    String msg;
    List<Usuario> data;

    RespuestaUsuario({
        required this.ok,
        required this.resp,
        required this.msg,
        required this.data,
    });

    factory RespuestaUsuario.fromRawJson(String str) => RespuestaUsuario.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RespuestaUsuario.fromJson(Map<String, dynamic> json) => RespuestaUsuario(
        ok: json["ok"],
        resp: json["resp"],
        msg: json["msg"],
        data: List<Usuario>.from(json["data"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "resp": resp,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Usuario {
    int id;
    String name;
    String firstName;

    Usuario({
        required this.id,
        required this.name,
        required this.firstName,
    });

    factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        name: json["name"],
        firstName: json["first_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first_name": firstName,
    };
}
