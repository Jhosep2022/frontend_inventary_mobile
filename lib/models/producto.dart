import 'dart:convert';

class RespuestaProductos {
    bool ok;
    int resp;
    String msg;
    List<Producto> data;

    RespuestaProductos({
        required this.ok,
        required this.resp,
        required this.msg,
        required this.data,
    });

    factory RespuestaProductos.fromRawJson(String str) => RespuestaProductos.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RespuestaProductos.fromJson(Map<String, dynamic> json) => RespuestaProductos(
        ok: json["ok"],
        resp: json["resp"],
        msg: json["msg"],
        data: List<Producto>.from(json["data"].map((x) => Producto.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "resp": resp,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Producto {
    int id;
    dynamic idLocalizacion;
    String sku;
    String name;
    int total;
    int idCompany;
    dynamic idUser;
    DateTime createdAt;
    DateTime updatedAt;

    Producto({
        required this.id,
        required this.idLocalizacion,
        required this.sku,
        required this.name,
        required this.total,
        required this.idCompany,
        required this.idUser,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Producto.fromRawJson(String str) => Producto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["id"],
        idLocalizacion: json["idLocalizacion"],
        sku: json["sku"],
        name: json["name"],
        total: json["total"],
        idCompany: json["id_company"],
        idUser: json["id_user"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idLocalizacion": idLocalizacion,
        "sku": sku,
        "name": name,
        "total": total,
        "id_company": idCompany,
        "id_user": idUser,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
