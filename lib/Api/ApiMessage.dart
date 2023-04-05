
class ApiMessage {
  String? message;

  ApiMessage({this.message});

  ApiMessage.fromJson(Map<String, dynamic> json) {
    if(json["message"] is String) {
      message = json["message"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    return _data;
  }
}