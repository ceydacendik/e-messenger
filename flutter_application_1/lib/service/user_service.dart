// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/post_model.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:http/http.dart' as http;

//WEB SERVİSTEKİ VERİLERE ULAŞMAK İÇİN YAZILDI
class UserService {
  //VERİYİ ALMAK İSTEDİĞİMİZ SİTENİN URLLERİ
  final String url = "https://reqres.in/api/users?page=2";
  final String baseUrl = "https://reqres.in/api/register";
  //HOME PAGE DEKİ SERVİSTEKİ VERİLERİ ALMAK İÇİN. OLUŞTURDUĞUMUZ MODEL ŞEKLİNDE CEVAP DÖNECEK USER MODEL
  Future<UsersModel?> fetchUsers() async {
    //SERVİSE GET METHODU İLE İSTEĞİMİZİ ATTIK
    var res = await http.get(Uri.parse(url));
    //İSTEK BAŞARILI İSE
    if (res.statusCode == 200) {
      //GELEN VERİYİ JSON FORMATINA CEVİRİP DÖNDÜRÜYORUZ YANİ BİZE GELEN VERİYİ KULLANMAK İÇİN
      var jsonBody = UsersModel.fromJson(jsonDecode(res.body));
      return jsonBody;
    } else {
      print("İstek başarısız oldu => ${res.statusCode}");
    }
    return null;
  }

  //LOGİN İŞLEMİ İÇİN YAZILDI. POST MODELDEKİ TOKEN DÖNÜYOR
  Future<PostModel?> login(
      String email, String password, BuildContext context) async {
    //POST METHODU İLE VERİ GÖNDERİYORUZ
    var response = await http.post(Uri.parse(baseUrl),
        //EMAİL VE PASSWORD GÖNDERİYORUZ
        body: ({
          'email': email,
          'password': password,
        }));
    //EĞER EŞLEŞİYORSA BAŞARILI HOMEPAGE E GÖNDER
    if (response.statusCode == 200) {
      var jsonBody = PostModel.fromJson(jsonDecode(response.body));
      Navigator.pushNamedAndRemoveUntil(
          context, '/mainnavbar', (route) => false);

      return jsonBody;
    } else {
      //DEĞİLSE HATA MESAKI YAYINLAR
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kullanıcı bilgileri yanlış')));
      print("İstek başarısız oldu => ${response.statusCode}");
    }
    return null;
  }
}
