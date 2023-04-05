import "dart:convert";
import "dart:typed_data";
import "package:http/http.dart" as http;
import "package:tampilan_lelang_ukk_jan_29_2023/Api/ApiAllUser.dart";
import "package:tampilan_lelang_ukk_jan_29_2023/Api/ApiHistoryLelang.dart";
import "package:tampilan_lelang_ukk_jan_29_2023/Api/ApiLelang.dart";

import "package:tampilan_lelang_ukk_jan_29_2023/Api/ApiLogin.dart";
import "package:tampilan_lelang_ukk_jan_29_2023/Api/ApiMessage.dart";
import "package:tampilan_lelang_ukk_jan_29_2023/Api/ApiUser.dart";
import 'package:http_parser/http_parser.dart';

const base_url = "https://lelang.enricko.com/api/";
const url_token = "ukk2023harus100";

class Api{

  static Future<ApiLogin> login(Map<String,String> data)async{
    var url = Uri.parse(base_url+"loginuser?token=${url_token}");
    var response = await http.post(url,body: data);

    return ApiLogin.fromJson(jsonDecode(response.body));
  }
  static Future<ApiLogin> register(Map<String,String> data)async{
    var url = Uri.parse(base_url+"register_masyarakat?token=${url_token}");
    var response = await http.post(url,body: data);

    return ApiLogin.fromJson(jsonDecode(response.body));
  }
  static Future<ApiLogin> registerAdmin(String token,Map<String,String> data)async{
    var url = Uri.parse(base_url+"register_admin?token=${url_token}");
    var response = await http.post(url,body: data,
    headers: {
      "Accept" : "application/json",
      "Authorization" : "Bearer ${token}"
    });
    
    print(url); 
    print(data); 

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
  static Future<ApiAllUser> getAllUser(String token,String filter)async{
    var url = Uri.parse(base_url+"all_user?token=${url_token}&${filter}");
    var response = await http.get(url,
    headers: {
      "Accept" : "application/json",
      "Authorization" : "Bearer ${token}"
    });

    return ApiAllUser.fromJson(jsonDecode(response.body));
  }


  static Future<ApiLelang> lelang(String token,String filter)async{
    var url = Uri.parse(base_url+"lelang?token=${url_token}&${filter}");
    var response = await http.get(url,
    headers: {
      "Accept" : "application/json",
      "Authorization" : "Bearer ${token}"
    });

    return ApiLelang.fromJson(jsonDecode(response.body));
  }
  static Future<ApiLelang> lelangPage(String filter)async{
    var url = Uri.parse(base_url+"lelang_page?token=${url_token}&${filter}");
    var response = await http.get(url);
    print(url);

    return ApiLelang.fromJson(jsonDecode(response.body));
  }
  static Future<ApiLelang> ikutLelang(String filter,String token)async{
    var url = Uri.parse(base_url+"lelang_ikut?token=${url_token}&${filter}");
    var response = await http.get(url,
    headers: {
      "Accept" : "application/json",
      "Authorization" : "Bearer ${token}"
    });

    return ApiLelang.fromJson(jsonDecode(response.body));
  }
  static Future<ApiHistoryLelang> historyLelang(bool user,String idLelang,String token)async{
    var response;
    var url;
    if (user == true) {
      url = Uri.parse(base_url+"history_lelang?token=${url_token}&id_lelang=${idLelang}&user=true");
    }
    url = Uri.parse(base_url+"history_lelang?token=${url_token}&id_lelang=${idLelang}");
    if(token == "" || token == null){
      response = await http.get(url);
    }else{
      response = await http.get(url,
      headers: {
        "Accept" : "application/json",
        "Authorization" : "Bearer ${token}"
      });
    }

    return ApiHistoryLelang.fromJson(jsonDecode(response.body));
  }
  static Future<ApiHistoryLelang> detailHistoryLelang(int id_lelang) async{
    var url = Uri.parse('${base_url}history_lelang?token=${url_token}&id_lelang=$id_lelang');

    var response = await http.get(url,headers: {'Accept': "application/json"});

    return ApiHistoryLelang.fromJson(jsonDecode(response.body));
    // throw "Gagal mengambil data";
  }


  static Future<ApiMessage> tawar(int tawar,String idLelang,String token)async{
    var url = Uri.parse(base_url+"tawar_lelang?token=${url_token}");
    var response = await http.post(url,
    body: {
      'tawar': tawar.toString(),
      'id_lelang': idLelang,
    },
    headers: {
      "Accept" : "application/json",
      "Authorization" : "Bearer ${token}"
    });

    return ApiMessage.fromJson(jsonDecode(response.body));
  }
  static Future<ApiMessage> insertLelang(Map data, String? baseImage, Uint8List? webImage,String token) async{
    var url = Uri.parse('${base_url}insert_lelang?token=${url_token}');
    var request = http.MultipartRequest("POST",url);
    request.files.add(http.MultipartFile.fromBytes('image_barang', webImage!,contentType: MediaType('application', 'octet-stream'),filename: 'image.png'));
    request.headers.addAll({'Content-Type': 'multipart/form-data','Accept':'application/json','Authorization':"Bearer $token"});
    request.fields['nama_barang'] = data['nama_barang'];
    request.fields['harga_awal'] = data['harga_awal'];
    request.fields['deskripsi_barang'] = data['deskripsi_barang'];
    request.fields['lama_lelang'] = data['lama_lelang'];

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);
    return ApiMessage.fromJson(responseData);
  } 
  static Future<ApiMessage> updateLelang(Map data, String? baseImage, Uint8List? webImage,String token,String idLelang) async{
    var url = Uri.parse('${base_url}update_lelang?token=${url_token}&id_lelang=${idLelang}');
    var request = http.MultipartRequest("POST",url);
    request.files.add(http.MultipartFile.fromBytes('image_barang', webImage!,contentType: MediaType('application', 'octet-stream'),filename: 'image.png'));
    request.headers.addAll({'Content-Type': 'multipart/form-data','Accept':'application/json','Authorization':"Bearer $token"});
    request.fields['nama_barang'] = data['nama_barang'];
    request.fields['harga_awal'] = data['harga_awal'];
    request.fields['deskripsi_barang'] = data['deskripsi_barang'];
    request.fields['lama_lelang'] = data['lama_lelang'];
    print(url);

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);
    return ApiMessage.fromJson(responseData);
  } 
  static Future<ApiMessage> deleteLelang(int id_lelang,String token) async{
    var url = Uri.parse('${base_url}delete_lelang?token=${url_token}&id_lelang=$id_lelang');

    var response = await http.get(url,headers: {'Accept': "application/json","Authorization" : "Bearer ${token}"});

    return ApiMessage.fromJson(jsonDecode(response.body));
    // throw "Gagal mengambil data";
  }
}