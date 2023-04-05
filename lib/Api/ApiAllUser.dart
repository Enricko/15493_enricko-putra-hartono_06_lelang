
class ApiAllUser {
  String? message;
  List<Data>? data;
  int? count;

  ApiAllUser({this.message, this.data, this.count});

  ApiAllUser.fromJson(Map<String, dynamic> json) {
    if(json["message"] is String) {
      message = json["message"];
    }
    if(json["data"] is List) {
      data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    }
    if(json["count"] is int) {
      count = json["count"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["count"] = count;
    return _data;
  }
}

class Data {
  int? id;
  String? idPetugas;
  String? name;
  String? email;
  dynamic telp;
  dynamic image;
  String? level;

  Data({this.id, this.idPetugas, this.name, this.email, this.telp, this.image, this.level});

  Data.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["id_petugas"] is String) {
      idPetugas = json["id_petugas"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    telp = json["telp"];
    image = json["image"];
    if(json["level"] is String) {
      level = json["level"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["id_petugas"] = idPetugas;
    _data["name"] = name;
    _data["email"] = email;
    _data["telp"] = telp;
    _data["image"] = image;
    _data["level"] = level;
    return _data;
  }
}