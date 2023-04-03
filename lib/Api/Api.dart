import "dart:convert";
import "package:http/http.dart" as http;
import "package:tampilan_lelang_ukk_jan_29_2023/Api/ApiLelang.dart";

import "package:tampilan_lelang_ukk_jan_29_2023/Api/ApiLogin.dart";
import "package:tampilan_lelang_ukk_jan_29_2023/Api/ApiUser.dart";

const base_url = "https://lelang.enricko.com/api/";
const url_token = "ukk2023harus100";

class Api{

  static Future<ApiLogin> login(Map<String,String> data)async{
    var url = Uri.parse(base_url+"loginuser?token=${url_token}");
    var response = await http.post(url,body: data);

    return ApiLogin.fromJson(jsonDecode(response.body));
  }
  static Future<ApiUser> getUser(String token)async{
    var url = Uri.parse(base_url+"get_user?token=${url_token}");
    var response = await http.get(url,
    headers: {
      "Accept" : "application/json",
      "Authorization" : "Bearer ${token}"
    });

    return ApiUser.fromJson(jsonDecode(response.body));
  }
  static Future<ApiLelang> lelangPage(String filter)async{
    var url = Uri.parse(base_url+"lelang_page?token=${url_token}&${filter}");
    var response = await http.get(url);

    return ApiLelang.fromJson(jsonDecode(response.body));
  }
}