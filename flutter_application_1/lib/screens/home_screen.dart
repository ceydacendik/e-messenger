import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/service/user_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //İSTEK ATTIĞIMIZI SERVİSİ KULLANMAK İÇİN BURADA ÇAĞIRDIK
  final UserService _service = UserService();
  //BOŞ BİR LİSTEYE ATIYORUZ KULLANICILARI SONRASINDA LİSTELEMEK İÇİN
  List<Data> users = [];
  //TRUE FALSE DEĞER OLUŞTURDUK EĞER VERİ VARSA TRUE OLACAK YOKSA GELENE KADAR CİRCLEPROGRESS DÖNECEK
  bool? isLoading = false;

  //UYGULAMA AÇILDIĞINDA İSTEK ATIYORUZ VE KULLANCIILARI GETİRTİYORUZ. BİR KONTROL YAPIYORUZ GELEN DATA BOŞ MU DOLU MU ONA GÖRE AKSİYON ALIYORUZ
  @override
  void initState() {
    super.initState();
    _service.fetchUsers().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          //EĞER VERİ GELDİYSE TRUE OLUYOR VE VERİLERİ GÖRÜYORUZ
          //YUKARIDA OLUŞTURDUĞUMUZ BOŞ LİSTEYE ATIYORUZ GELEN DATAYI
          users = value.data!;
          isLoading = true;
        });
      } else {
        setState(() {
          //VERİ YOKSA FALSE OLUYOR
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Persons App',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        //EĞER VERİ GELMİYORSA BOŞSA HATA MESAJI
        body: isLoading == null
            ? const Center(
                child: Text('Bir hata oluştu'),
              )
            //EĞER GELDİYSE LİSTVİEWBUİLDER İLE VERİLERİ EKRANDA GÖSTERİYORUZ
            : isLoading == true
                ? ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      //GELEN VERİLERİ YUKARIDAKİ LİSTEYE ATMIŞTIK BURADA DA O LİSTEYİ İNDEXE GÖRE YAZDIRIYORUZ
                      var user = users[index];
                      return Card(
                        elevation: 2,
                        color: Colors.white,
                        child: ListTile(
                          //LİSTENİN İÇİNDEN İLK ADI VE SON ADINI KULLANDIK
                          title: Text(user.firstName! + user.lastName!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          //LİSTENİN İÇİNDEN E MAİL ADRESİNİ KULLANDIK
                          subtitle: Text(user.email!),
                          leading: CircleAvatar(
                            radius: 30,
                            //RESMİNİ KULLANDIK
                            backgroundImage: NetworkImage(user.avatar!),
                          ),
                        ),
                      );
                    },
                  )
                //EĞER VERİLER GELMEDİYSE CİRCLEPROGRESS DÖNDÜRÜYORUZ
                : const Center(
                    child: CircularProgressIndicator(),
                  ));
  }
}
