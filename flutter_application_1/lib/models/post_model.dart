//LOGİN OLMAK İÇİN GEREKEN MODEL BİZE BİR TOKEN DÖNDÜRÜYOR O TOKENE GÖRE KULLANICI DOĞRU MU DEĞİL Mİ KONTROL EDİLİYOR
class PostModel {
  String? token;

  PostModel({this.token});

  PostModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
